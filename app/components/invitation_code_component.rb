# frozen_string_literal: true

class InvitationCodeComponent < ViewComponent::Base
  def initialize(current_user:, class_name: '')
    @current_user = current_user
    @class_name = class_name

    @user_group = current_user.group
    @invitation_code = @user_group.invitation_code
  end

  private

  def render?
    current_user.owner?
  end

  attr_reader :current_user
end
