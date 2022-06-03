# frozen_string_literal: true

module ActivityLogs
  class GroupMemberAddedLog < ApplicationRecord
    include Loggable

    def text
      user_name = "#{activity_log.user.name}さん"
      @text ||= "⇨ #{bold(user_name)}がグループに参加しました。"
    end
  end
end
