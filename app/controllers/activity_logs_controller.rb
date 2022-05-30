# frozen_string_literal: true

class ActivityLogsController < ApplicationController
  def index
    @activity_logs = ActivityLog.for_notification_of_group(current_user.group)
  end
end
