require "test_helper"

class RepetitiveTaskTest < ActiveSupport::TestCase
  describe 'responses' do
    let(:repetitive_task) { repetitive_tasks(:one) }

    it 'responses correctly' do
      expect(repetitive_task).must_respond_to(:name)
      expect(repetitive_task).must_respond_to(:interval_days)
      expect(repetitive_task).must_respond_to(:user_group)
      expect(repetitive_task).must_respond_to(:user_group_id)
      expect(repetitive_task).must_respond_to(:logs)
      expect(repetitive_task).must_respond_to(:done_today?)
      expect(repetitive_task).must_respond_to(:today_log)
      expect(repetitive_task).must_respond_to(:last_done_at)
      expect(repetitive_task).must_respond_to(:never_done?)
      expect(repetitive_task).must_respond_to(:days_since_last_done)
      expect(repetitive_task).must_respond_to(:days_until_next)
      expect(repetitive_task).must_respond_to(:should_do_today?)
    end
  end

  describe 'validations' do
    let(:repetitive_task) { repetitive_tasks(:barely_valid) }

    it 'バリデーション通る' do
      expect(repetitive_task.valid?).must_equal true
    end

    it 'nameが空ならバリデーションエラー' do
      repetitive_task.name = ''
      expect(repetitive_task.valid?).must_equal false
      expect(repetitive_task.errors[:name]).must_include "を入力してください"
    end

    it 'nameが21文字以上ならバリデーションエラー' do
      repetitive_task.name = 'a' * 21
      expect(repetitive_task.valid?).must_equal false
      expect(repetitive_task.errors[:name]).must_include "は20文字以内で入力してください"
    end

    it 'interval_daysが空ならバリデーションエラー' do
      repetitive_task.interval_days = nil
      expect(repetitive_task.valid?).must_equal false
      expect(repetitive_task.errors[:interval_days]).must_include "を入力してください"
    end

    it 'interval_daysが0ならバリデーションエラー' do
      repetitive_task.interval_days = 0
      expect(repetitive_task.valid?).must_equal false
      expect(repetitive_task.errors[:interval_days]).must_include "は0より大きい値にしてください"
    end

    it 'interval_daysが1000ならバリデーションエラー' do
      repetitive_task.interval_days = 1000
      expect(repetitive_task.valid?).must_equal false
      expect(repetitive_task.errors[:interval_days]).must_include "は1000より小さい値にしてください"
    end
  end

  describe 'instance methods' do
    let(:repetitive_task) { repetitive_tasks(:without_logs) }

    describe '#done_today?' do
      it '今日のログがあるならtrue' do
        repetitive_task.logs.create!(date: Date.today)
        expect(repetitive_task.done_today?).must_equal true
      end

      it '今日のログがないならfalse' do
        repetitive_task.logs.create!(date: Date.tomorrow)
        expect(repetitive_task.done_today?).must_equal false
      end
    end

    describe '#today_log' do
      it '今日のログがあるならそのログ' do
        today_log = repetitive_task.logs.create!(date: Date.today)
        expect(repetitive_task.today_log).must_equal today_log
      end

      it '今日のログがないならnil' do
        repetitive_task.logs.create!(date: Date.tomorrow)
        expect(repetitive_task.today_log).must_be_nil
      end
    end

    describe '#last_done_at' do
      it 'ログがあるならその日付' do
        repetitive_task.logs.create!(date: Date.today)
        expect(repetitive_task.last_done_at).must_equal Date.today
      end

      it 'ログがないならnil' do
        expect(repetitive_task.logs.count).must_equal 0
        expect(repetitive_task.last_done_at).must_be_nil
      end
    end

    describe '#never_done?' do
      it 'ログがないならtrue' do
        expect(repetitive_task.logs.count).must_equal 0
        expect(repetitive_task.never_done?).must_equal true
      end
    end

    describe '#days_since_last_done' do
      it 'ログがないなら0' do
        expect(repetitive_task.logs.count).must_equal 0
        expect(repetitive_task.days_since_last_done).must_equal 0
      end

      it 'ログがあればその日付から今日までの日数' do
        repetitive_task.logs.create!(date: Date.yesterday)
        expect(repetitive_task.days_since_last_done).must_equal 1

        repetitive_task.logs.create!(date: Date.today)
        expect(repetitive_task.days_since_last_done).must_equal 0
      end
    end

    describe '#days_until_next' do
      it 'ログがないなら0' do
        expect(repetitive_task.logs.count).must_equal 0
        expect(repetitive_task.days_until_next).must_equal 0
      end

      it 'ログがあれば次にやる日までの日数' do
        repetitive_task.logs.create!(date: Date.yesterday - 3)
        expect(repetitive_task.days_until_next).must_equal 0

        repetitive_task.logs.create!(date: Date.yesterday - 2)
        expect(repetitive_task.days_until_next).must_equal 0

        repetitive_task.logs.create!(date: Date.yesterday - 1)
        expect(repetitive_task.days_until_next).must_equal 1

        repetitive_task.logs.create!(date: Date.yesterday)
        expect(repetitive_task.days_until_next).must_equal 2

        repetitive_task.logs.create!(date: Date.today)
        expect(repetitive_task.days_until_next).must_equal 3
      end
    end

    describe '#should_do_today?' do
      it '次にやる日までの日数が0ならtrue' do
        repetitive_task.logs.create!(date: Date.yesterday - 3)
        expect(repetitive_task.should_do_today?).must_equal true

        repetitive_task.logs.create!(date: Date.yesterday - 2)
        expect(repetitive_task.should_do_today?).must_equal true
      end

      it '次にやる日までの日数が0より大きいならfalse' do
        repetitive_task.logs.create!(date: Date.yesterday - 1)
        expect(repetitive_task.should_do_today?).must_equal false

        repetitive_task.logs.create!(date: Date.yesterday)
        expect(repetitive_task.should_do_today?).must_equal false

        repetitive_task.logs.create!(date: Date.today)
        expect(repetitive_task.should_do_today?).must_equal false
      end
    end
  end
end
