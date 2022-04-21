class UsersController < ApplicationController
  skip_before_action :check_logged_in, only: :create

  def create
    if invited?
      inviter = User.find_by(email: invitation_params[:inviter_email])
      if valid_invitation?(inviter)
        user = User.create!(user_params.merge(group_id: inviter.group_id))
      else
        flash[:danger] = '招待者のGmailアドレスか招待コードが違います'
        redirect_to root_path
      end
    else
      user = User.create_with_group!(user_params)
    end
    log_in user
    redirect_to repetitive_tasks_path
  end

  def destroy
    user = User.find(params[:id])
    if user.id == current_user.id
      log_out
      user.destroy!
      redirect_to root_path
    else
      user.destroy!
      redirect_to user_groups_path
    end
  end

  private

  def invited?
    !invitation_params[:invitation_code].nil? && !invitation_params[:inviter_email].nil?
  end

  def valid_invitation?(inviter)
    inviter && inviter.group.valid_invitation_code?(invitation_params[:invitation_code])
  end

  def user_params
    params.permit(:name, :email)
  end

  def invitation_params
    params.permit(:invitation_code, :inviter_email)
  end
end
