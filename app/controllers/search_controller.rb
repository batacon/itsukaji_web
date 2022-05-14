class SearchController < ApplicationController
  def search
    @repetitive_tasks = RepetitiveTask.search_by_name(name_query).main_list_for_user(current_user)
    respond_to(&:turbo_stream)
  end

  private

  def name_query
    params.permit(:name)[:name]
  end
end
