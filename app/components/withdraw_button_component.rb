# frozen_string_literal: true

class WithdrawButtonComponent < ViewComponent::Base
  include SessionsHelper

  def initialize(class_name: '')
    @class_name = class_name
  end

  def render?
    current_user.owner?
  end
end
