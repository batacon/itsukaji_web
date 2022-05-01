# frozen_string_literal: true

class WithdrawButtonComponent < ViewComponent::Base
  def initialize(current_user:, class_name: '')
    @current_user = current_user
    @class_name = class_name
  end

  private

  def render?
    current_user.owner?
  end

  def current_user
    @current_user
  end
end
