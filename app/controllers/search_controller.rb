# frozen_string_literal: true

class SearchController < ApplicationController
  def search
    all_repetitive_tasks ||= RepetitiveTask.main_list_for_user(current_user)
    @repetitive_tasks = all_repetitive_tasks.search_by_name(name_query).sorted_array_by_due_date
    respond_to(&:turbo_stream)
  end

  private

  def name_query
    params.permit(:name)[:name]
  end
end
