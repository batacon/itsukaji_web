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
    if @user.owner? && @user.id == current_user.id
      '自分(オーナー)'
    elsif @user.id == current_user.id
      '自分'
    elsif @user.owner?
      'オーナー'
    end
  end
end
