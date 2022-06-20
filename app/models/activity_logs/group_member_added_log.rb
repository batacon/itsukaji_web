# frozen_string_literal: true

module ActivityLogs
  class GroupMemberAddedLog < ApplicationRecord
    include Loggable

    def emoji
      '⇨'
    end

    def text
      'がグループに参加しました。'
    end
  end
end
