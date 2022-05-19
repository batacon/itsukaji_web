# frozen_string_literal: true

class WelcomeController < ApplicationController
  skip_before_action :check_logged_in, only: :index

  def index
    return redirect_to root_path unless user_params

    @name = user_params[:name]
    @email = user_params[:email]
  end

  private

  def user_params
    params.require(:user).permit(:name, :email) if params[:user]
  end
end
