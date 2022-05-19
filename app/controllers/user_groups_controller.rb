# frozen_string_literal: true

class UserGroupsController < ApplicationController
  def index
    @user_group = UserGroup.find(current_user.group.id)
    @users = @user_group.users
  end

  def update
    user_group = UserGroup.find(params[:id])
    user_group.regenerate_invitation_code
    redirect_to user_groups_path
  end

  def destroy
    user_group = UserGroup.find(params[:id])
    user_group.destroy!
    redirect_to root_path
  end
end
