# frozen_string_literal: true

class InvitationCodeComponent < ViewComponent::Base
  def initialize(current_user:, class_name: '')
    @current_user = current_user
    @class_name = class_name
  end

  private

  def render?
    current_user.owner?
  end

  def invitation_code
    user_group.invitation_code
  end

  def user_group
    current_user.group
  end

  def current_user
    @current_user
  end
end
