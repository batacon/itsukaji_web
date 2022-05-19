# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :check_logged_in, only: :index
  before_action :redirect_to_tasks_list, only: :index, if: :logged_in?

  layout 'home'

  def index; end

  private

  def redirect_to_tasks_list
    redirect_to repetitive_tasks_path
  end
end
