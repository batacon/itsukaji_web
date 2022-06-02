# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :check_logged_in, only: :create

  def create
    user = invited? ? User.create_by_invitation(create_user_params, invitation_params) : User.create_with_group_as_owner!(create_user_params)
    return redirect_to welcome_path(user: create_user_params) unless user

    log_in user
    redirect_to repetitive_tasks_path
  end

  def edit
    @user = current_user
  end

  def update
    current_user.update!(update_user_params)
    redirect_to repetitive_tasks_path
  end

  # TODO: アクティビティログを残すなら、論理削除にした方が良いかも？
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
    inviter&.group&.valid_invitation_code?(invitation_params[:invitation_code])
  end

  def create_user_params
    params.permit(:name, :email)
  end

  def invitation_params
    params.permit(:invitation_code, :inviter_email)
  end

  def update_user_params
    params.require(:user).permit(:name)
  end
end
