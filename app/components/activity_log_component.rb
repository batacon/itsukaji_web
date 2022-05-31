# frozen_string_literal: true

class ActivityLogComponent < ViewComponent::Base
  with_collection_parameter :activity_log

  def initialize(activity_log:, current_user:)
    @activity_log_datetime = activity_log.created_at.strftime('%Y-%m-%d %H:%M')
    @activity_log_text = activity_log.text
    @highlighted = activity_log.should_highlight_for?(current_user)
  end

  private

  def highlighted?
    @highlighted
  end
end
