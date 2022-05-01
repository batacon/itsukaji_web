# frozen_string_literal: true

require "test_helper"

class DoneButtonComponentTest < ViewComponent::TestCase
  before { render_inline(DoneButtonComponent.new(repetitive_task:)) }

  describe '今日やったタスク' do
    let(:repetitive_task) { repetitive_tasks(:done_today) }

    it '今日やったという表示になっている' do
      expect(page.find('img')[:src]).must_include 'balloon_blue_done'
    end

    it 'クリックしたら今日のログを削除するようなフォームになっている' do
      expect(page.find('form')[:action]).must_equal "/repetitive_tasks/#{repetitive_task.id}/repetitive_task_logs/#{repetitive_task.today_log.id}"
      expect(page.find_field(type: 'hidden')[:value]).must_equal 'delete'
    end
  end

  describe '今日やるべきタスク' do
    let(:repetitive_task) { repetitive_tasks(:without_logs) }

    it '今日やるべきという表示になっている' do
      expect(page.find('img')[:src]).must_include 'balloon_red_yet'
    end

    it 'クリックしたら今日のログを作成するようなフォームになっている' do
      expect(page.find('form')[:action]).must_equal "/repetitive_tasks/#{repetitive_task.id}/repetitive_task_logs"
    end
  end

  describe 'まだやらなくていいタスク' do
    let(:repetitive_task) { repetitive_tasks(:done_yesterday) }

    it 'まだやらなくていいという表示になっている' do
      expect(page.find('img')[:src]).must_include 'balloon_blue_yet'
    end

    it 'クリックしたら今日のログを作成するようなフォームになっている' do
      expect(page.find('form')[:action]).must_equal "/repetitive_tasks/#{repetitive_task.id}/repetitive_task_logs"
    end
  end
end
