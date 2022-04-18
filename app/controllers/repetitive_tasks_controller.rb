class RepetitiveTasksController < ApplicationController
  before_action :set_repetitive_task, only: [:show, :edit, :update, :destroy]

  def index
    @repetitive_tasks = RepetitiveTask.where(user_id: current_user.id).sort_by(&:days_until_next)
  end

  def new
    @repetitive_task = RepetitiveTask.new
  end

  def create
    RepetitiveTask.create!(repetitive_task_params)
    redirect_to :repetitive_tasks
  end

  def edit
  end

  def update
    @repetitive_task.update!(repetitive_task_params)
    redirect_to :repetitive_tasks
  end

  def destroy
    @repetitive_task.destroy!
    redirect_to :repetitive_tasks
  end

  private

  def set_repetitive_task
    @repetitive_task = RepetitiveTask.find(params[:id])
  end

  def repetitive_task_params
    params.require(:repetitive_task).permit(:name, :interval_days).merge(user_id: current_user.id)
  end
end
