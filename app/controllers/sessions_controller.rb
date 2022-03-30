class SessionsController < ApplicationController
  skip_before_action :check_logged_in, only: :create

  def create
    if (user = User.find_or_create_from_auth_hash(auth_hash))
      log_in user
      # TODO: taskの一覧ページにリダイレクトする
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
