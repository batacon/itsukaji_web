# frozen_string_literal: true

require 'test_helper'

class TaskCreateLogTest < ActiveSupport::TestCase
  let(:user) { users(:member1_of_group1) }
  let(:user_group) { user.group }
  let(:repetitive_task) { repetitive_tasks(:without_logs) }
  let(:activity_log) { ActivityLog.create!(user:, user_group:, loggable: ActivityLogs::TaskCreateLog.new(repetitive_task:)) }

  describe 'responses' do
    it 'responses correctly' do
      expect(activity_log).must_respond_to(:user_group)
      expect(activity_log).must_respond_to(:user)
      expect(activity_log).must_respond_to(:text)
      expect(activity_log.loggable).must_respond_to(:repetitive_task)
    end
  end

  describe 'instance methods' do
    describe '#text' do
      it 'returns correct text' do
        expect(activity_log.text).must_equal("#{user.name}さんが新タスク「#{repetitive_task.name}」を作成しました。")
      end
    end
  end
end
