# frozen_string_literal: true

require 'test_helper'

class GroupMemberAddedLogTest < ActiveSupport::TestCase
  let(:user) { users(:member1_of_group1) }
  let(:user_group) { user.group }
  let(:activity_log) do
    ActivityLog.create!(user:, user_group:, loggable: ActivityLogs::GroupMemberAddedLog.new)
  end

  describe 'responses' do
    it 'responses correctly' do
      expect(activity_log).must_respond_to(:user_group)
      expect(activity_log).must_respond_to(:user)
      expect(activity_log).must_respond_to(:text)
    end
  end

  describe 'instance methods' do
    describe '#text' do
      it 'returns correct text' do
        expect(activity_log.text).must_equal("#{activity_log.user.name}さんがグループに参加しました。")
      end
    end
  end
end
