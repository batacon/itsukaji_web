# frozen_string_literal: true

class ActivityLogComponent < ViewComponent::Base
  def initialize(activity_log:)
    @activity_log_datetime = activity_log.created_at.strftime('%Y-%m-%d %H:%M')
    @activity_log_text = activity_log.text
  end
end
