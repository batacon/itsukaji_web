# frozen_string_literal: true

require 'test_helper'

class TaskDoneLogTest < ActiveSupport::TestCase
  let(:user) { users(:member1_of_group1) }
  let(:user_group) { user.group }
  let(:repetitive_task) { repetitive_tasks(:without_logs) }
  let(:activity_log) do
    ActivityLog.create!(user:, user_group:, loggable: ActivityLogs::TaskDoneLog.new(repetitive_task:))
  end

  describe 'responses' do
    it 'responses correctly' do
      expect(activity_log).must_respond_to(:user_group)
      expect(activity_log).must_respond_to(:user)
      expect(activity_log).must_respond_to(:text)
      expect(activity_log).must_respond_to(:emoji)
      expect(activity_log).must_respond_to(:should_highlight_for?)
      expect(activity_log.loggable).must_respond_to(:repetitive_task)
    end
  end

  describe 'instance methods' do
    describe '#text' do
      it 'returns correct text' do
        expect(activity_log.text).must_include(repetitive_task.name)
        expect(activity_log.text).must_include('を完了しました！')
      end
    end
  end
end
