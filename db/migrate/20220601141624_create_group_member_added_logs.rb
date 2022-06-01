# frozen_string_literal: true

class CreateGroupMemberAddedLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :group_member_added_logs, &:timestamps
  end
end
