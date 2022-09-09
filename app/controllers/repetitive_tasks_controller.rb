# frozen_string_literal: true

class RepetitiveTasksController < ApplicationController
  before_action :set_repetitive_task_and_check_own_group, only: %i[edit update destroy]

  def index
    @repetitive_tasks = RepetitiveTask.main_list_for_user(current_user)
  end

  def new
    @repetitive_task = RepetitiveTask.new
  end

  def create
    ActiveRecord::Base.transaction do
      task = RepetitiveTask.create!(repetitive_task_params)
      task.logs.create!(date: log_params[:last_done_at]) if log_params[:last_done_at].present?
      ActivityLog.create!(
        user_group: current_user.group,
        user: current_user,
        loggable: ActivityLogs::TaskCreateLog.new(repetitive_task: task)
      )
    end
    redirect_to :repetitive_tasks
  end

  def edit; end

  def update
    @repetitive_task.update!(repetitive_task_params)
    redirect_to :repetitive_tasks
  end

  def destroy
    ActiveRecord::Base.transaction do
      ActivityLog.create!(
        user_group: current_user.group,
        user: current_user,
        loggable: ActivityLogs::TaskDeleteLog.new(task_name: @repetitive_task.name)
      )
      @repetitive_task.destroy!
    end
    redirect_to :repetitive_tasks
  end

  private

  def set_repetitive_task_and_check_own_group
    @repetitive_task = RepetitiveTask.find(params[:id])
    redirect_to repetitive_tasks_path unless current_user.member_of?(@repetitive_task.user_group)
  end

  def repetitive_task_params
    params.require(:repetitive_task).permit(:name, :interval_days).merge(user_group_id: current_user.group.id)
  end

  def log_params
    params.require(:repetitive_task).permit(:last_done_at)
  end
end
