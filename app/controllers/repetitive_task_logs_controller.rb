# frozen_string_literal: true

class RepetitiveTaskLogsController < ApplicationController
  before_action :set_repetitive_task
  before_action :set_repetitive_task_log, only: %i[update destroy]

  def create
    ActiveRecord::Base.transaction do
      ActivityLog.create!(
        user_group: current_user.group,
        user: current_user,
        loggable: ActivityLogs::TaskDoneLog.new(repetitive_task: @repetitive_task)
      )
      @repetitive_task.logs.create!(date: Date.today)
    end
    respond_to(&:turbo_stream)
  end

  def update
    ActiveRecord::Base.transaction do
      ActivityLog.create!(
        user_group: current_user.group,
        user: current_user,
        loggable: ActivityLogs::TaskLogDateChangeLog.new(
          repetitive_task: @repetitive_task,
          from: @repetitive_task_log.date,
          to: log_params[:date]
        )
      )
      @repetitive_task_log.update!(log_params)
    end
    respond_to(&:turbo_stream)
  end

  def destroy
    ActiveRecord::Base.transaction do
      ActivityLog.create!(
        user_group: current_user.group,
        user: current_user,
        loggable: ActivityLogs::TaskUndoneLog.new(repetitive_task: @repetitive_task)
      )
      @repetitive_task_log.destroy!
    end
    respond_to(&:turbo_stream)
  end

  private

  def set_repetitive_task
    @repetitive_task = RepetitiveTask.find(params[:repetitive_task_id])
  end

  def set_repetitive_task_log
    @repetitive_task_log = RepetitiveTaskLog.find(params[:id])
  end

  def log_params
    params.require(:repetitive_task_log).permit(:date)
  end
end
