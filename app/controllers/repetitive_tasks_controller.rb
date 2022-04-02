class RepetitiveTasksController < ApplicationController
  def index
    @repetitive_tasks = RepetitiveTask.where(user_id: current_user.id)
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

    # if @repetitive_task.save
    #   redirect_to :repetitive_tasks
    # else
    #   render :new
    # end
  end

  def edit
    @repetitive_task = RepetitiveTask.find(params[:id])
  end

  def update
    # @article = Article.find(params[:id])

    # if @article.update(article_params)
    #   redirect_to @article
    # else
    #   render :edit
    # end
  end

  private

  def repetitive_task_params
    params.require(:repetitive_task).permit(:name, :interval_days).merge(user_id: current_user.id)
  end
end
