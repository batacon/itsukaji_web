# frozen_string_literal: true

class InvitationCodeComponent < ViewComponent::Base
  include SessionsHelper

  def initialize(class_name: '')
    @class_name = class_name
  end

  def render?
    current_user.owner?
  end

  def invitation_code
    user_group.invitation_code
  end

  def user_group
    current_user.group
  end
end
