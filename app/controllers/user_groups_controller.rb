class UserGroupsController < ApplicationController
  def index
    @user_group = UserGroup.find(current_user.group.id)
    @invitation_code = @user_group.invitation_code
    @users = @user_group.users
  end

  def update
    user_group = UserGroup.find(params[:id])
    user_group.regenerate_invitation_code
    redirect_to user_group_path(user_group)
  end
end
