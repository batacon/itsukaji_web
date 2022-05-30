# frozen_string_literal: true

class HeaderComponent < ViewComponent::Base
  def initialize(current_user:)
    @current_user = current_user
  end

  private

  def activity_icon
    @current_user.activity_to_highlight_exists? ? 'icon_activity_red' : 'icon_activity_white'
  end

  attr_reader :current_user
end
