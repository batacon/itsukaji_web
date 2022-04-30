# frozen_string_literal: true

class HeaderMenuComponent < ViewComponent::Base
  include SessionsHelper

  def render?
    !!current_user
  end
end
