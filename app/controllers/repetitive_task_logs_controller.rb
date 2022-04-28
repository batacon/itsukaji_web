class RepetitiveTaskLogsController < ApplicationController
  before_action :set_repetitive_task
  before_action :set_repetitive_task_log, only: %i[update destroy]

  def create
    @repetitive_task.logs.create!(date: Date.today)
    respond_to do |format|
      format.turbo_stream
    end
  end

  def update
    @repetitive_task_log.update!(params.require(:repetitive_task_log).permit(:date))
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @repetitive_task_log.destroy!
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_repetitive_task
    @repetitive_task = RepetitiveTask.find(params[:repetitive_task_id])
  end

  def set_repetitive_task_log
    @repetitive_task_log = RepetitiveTaskLog.find(params[:id])
  end
end
