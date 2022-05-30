# frozen_string_literal: true

class ActivityLogsController < ApplicationController
  after_action :update_check_activity_logs_at, only: :index

  def index
    @activity_logs = ActivityLog.for_notification_of_group(current_user.group)
  end

  private

  def update_check_activity_logs_at
    current_user.update!(last_check_activity_logs_at: Time.zone.now)
  end
end
