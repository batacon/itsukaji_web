# frozen_string_literal: true

class UserComponent < ViewComponent::Base
  include SessionsHelper

  def initialize(user:)
    @user = user
  end

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

  def owner?
    @user.owner?
  end

  def me?
    @user.id == current_user.id
  end

  def removable_user?
    current_user.owner? && !owner?
  end
end
