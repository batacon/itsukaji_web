class UsersController < ApplicationController
  skip_before_action :check_logged_in, only: :create

  def create
    unless invited?
      user = User.create_with_group!(user_params)
      log_in user
      return redirect_to repetitive_tasks_path
    end

    if user = User.create_by_invitation(user_params, invitation_params)
      log_in user
      return redirect_to repetitive_tasks_path
    end
    flash[:danger] = '招待者のGmailアドレスか招待コードが違います' # TODO: flashを表示
    redirect_to welcome_index_path(user: user_params)
  end

  def destroy
    target_user = User.find(params[:id])
    if target_user.id == current_user.id
      log_out
      target_user.destroy!
      redirect_to root_path
    elsif current_user.able_to_destroy?(target_user)
      target_user.destroy!
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
