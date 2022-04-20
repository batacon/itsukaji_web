class WelcomeController < ApplicationController
  skip_before_action :check_logged_in, only: :index

  def index
    @name = params[:user][:name]
    @email = params[:user][:email]
  end
end
