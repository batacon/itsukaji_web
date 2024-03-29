# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :check_logged_in, only: :create

  def create
    user = User.find_by(email: user_params[:email])
    return redirect_to welcome_path(user: user_params) unless user

    log_in user
    redirect_to repetitive_tasks_path
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def user_params
    {
      name: auth_hash.info.name,
      email: auth_hash.info.email
    }
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
