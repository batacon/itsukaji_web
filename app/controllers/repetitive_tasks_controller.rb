class RepetitiveTasksController < ApplicationController
  def index
    @repetitive_tasks = RepetitiveTask.where(user_id: current_user.id).order(:days_until_next)
  end

  def show
  end

  def new
    @repetitive_task = RepetitiveTask.new
  end

  def create
    @repetitive_task = RepetitiveTask.new(repetitive_task_params)
    @repetitive_task.save!
    redirect_to :repetitive_tasks
  end

  def edit
    @repetitive_task = RepetitiveTask.find(params[:id])
  end

  def update
    @repetitive_task = RepetitiveTask.find(params[:id])
    @repetitive_task.update!(repetitive_task_params)
    redirect_to :repetitive_tasks
  end

  private

  def repetitive_task_params
    params.require(:repetitive_task).permit(:name, :interval_days).merge(user_id: current_user.id)
  end
end
