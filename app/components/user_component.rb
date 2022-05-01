# frozen_string_literal: true

class UserComponent < ViewComponent::Base
  def initialize(user:, current_user:)
    @user = user
    @current_user = current_user
  end

  private

  def user_name
    @user.name
  end

  def label
    if owner? && me?
      '(自分/オーナー)'
    elsif me?
      '(自分)'
    elsif owner?
      '(オーナー)'
    end
  end

  def can_leave_group?
    me? && !owner?
  end

  def can_remove_target_user?
    current_user.owner? && !owner?
  end

  def owner?
    @user.owner?
  end

  def me?
    @user.id == current_user.id
  end

  def current_user
    @current_user
  end
end
