# frozen_string_literal: true

require 'test_helper'

class TaskLogDateChangeLogTest < ActiveSupport::TestCase
  let(:user) { users(:member1_of_group1) }
  let(:user_group) { user.group }
  let(:repetitive_task) { repetitive_tasks(:done_today) }
  let(:from) { repetitive_task.logs.last.date }
  let(:to) { from - 1.day }
  let(:activity_log) do
    ActivityLog.create!(
      user:,
      user_group:,
      loggable: ActivityLogs::TaskLogDateChangeLog.new(repetitive_task:, from:, to:)
    )
  end

  describe 'responses' do
    it 'responses correctly' do
      expect(activity_log).must_respond_to(:user_group)
      expect(activity_log).must_respond_to(:user)
      expect(activity_log).must_respond_to(:text)
      expect(activity_log).must_respond_to(:emoji)
      expect(activity_log).must_respond_to(:should_highlight_for?)
      expect(activity_log.loggable).must_respond_to(:repetitive_task)
      expect(activity_log.loggable).must_respond_to(:from)
      expect(activity_log.loggable).must_respond_to(:to)
    end
  end

  describe 'instance methods' do
    describe '#text' do
      it 'returns correct text' do
        expect(activity_log.text).must_include(repetitive_task.name)
        expect(activity_log.text).must_include("のやった！ログを#{from}から#{to}に変更しました。")
      end
    end
  end
end
