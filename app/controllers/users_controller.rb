class UsersController < ApplicationController
  skip_before_action :check_logged_in, only: :create

  def create
    if invited?
      inviter = User.find_by(email: user_params[:inviter_email])
      if inviter && inviter.group.invitation_code == user_params[:invitation_code]
        user = User.create!(name: user_params[:name], email: user_params[:email], group_id: inviter.group_id)
        log_in user
        redirect_to repetitive_tasks_path
      else
        flash[:danger] = '招待者のGmailアドレスか招待コードが違います'
        redirect_to root_path
      end
    else
      ActiveRecord::Base.transaction do
        new_group = UserGroup.create!
        user = User.create!(name: user_params[:name], email: user_params[:email], group_id: new_group.id)
        new_group.update!(owner_id: user.id)
      end
      log_in user
      redirect_to repetitive_tasks_path
    end
  end

  private

  def invited?
    !user_params[:invitation_code].nil? && !user_params[:inviter_email].nil?
  end

  def user_params
    params.permit(:name, :email, :invitation_code, :inviter_email)
  end
end
