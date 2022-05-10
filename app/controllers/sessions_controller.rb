class SessionsController < ApplicationController
  skip_before_action :check_logged_in, only: :create

  def create
    if user = User.find_by(email: user_params[:email])
      log_in user
      redirect_to repetitive_tasks_path
    else
      redirect_to welcome_index_path(user: user_params)
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def user_params
    {
      name: auth_hash.info.name,
      email: auth_hash.info.email,
    }
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
