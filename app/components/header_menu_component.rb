# frozen_string_literal: true

class HeaderMenuComponent < ViewComponent::Base
  def initialize(current_user:)
    @current_user = current_user
  end

  private

  def render?
    !!@current_user
  end

  def current_user
    @current_user
  end
end
