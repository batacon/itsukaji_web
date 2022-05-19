# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :check_logged_in

  def check_logged_in
    return if logged_in?

    redirect_to root_path
  end
end
