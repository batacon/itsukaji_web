require "test_helper"

class RepetitiveTaskLogTest < ActiveSupport::TestCase
  describe 'responses' do
    let(:repetitive_task_log) { repetitive_task_logs(:today) }

    it 'responses correctly' do
      expect(repetitive_task_log).must_respond_to(:repetitive_task)
      expect(repetitive_task_log).must_respond_to(:how_many_days_ago)
    end
  end

  describe 'validations' do
    let(:repetitive_task_log) { repetitive_task_logs(:today) }

    it 'バリデーション通る' do
      expect(repetitive_task_log.valid?).must_equal true
    end

    it 'dateが空ならバリデーションエラー' do
      repetitive_task_log.date = nil
      expect(repetitive_task_log.valid?).must_equal false
      expect(repetitive_task_log.errors[:date]).must_include "を入力してください"
    end
  end

  describe 'instance methods' do
    describe '#how_may_days_ago' do
      it '今日なら0' do
        today_log = repetitive_task_logs(:today)
        expect(today_log.how_many_days_ago).must_equal 0
      end

      it '1日前なら1' do
        yesterday_log = repetitive_task_logs(:yesterday)
        expect(yesterday_log.how_many_days_ago).must_equal 1
      end
    end
  end
end
