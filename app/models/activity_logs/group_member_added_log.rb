# frozen_string_literal: true

module ActivityLogs
  class GroupMemberAddedLog < ApplicationRecord
    include Loggable

    def text
      @text ||= "#{activity_log.user.name}さんがグループに参加しました。"
    end
  end
end
