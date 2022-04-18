# frozen_string_literal: true

class RepetitiveTaskLogComponent < ViewComponent::Base
  def initialize(repetitive_task_log:)
    @repetitive_task_log = repetitive_task_log
  end

  def date
    @repetitive_task_log.date
  end

  def how_many_days_ago
    days_number = @repetitive_task_log.how_many_days_ago
    days_number.zero? ? '今日' : "#{days_number}日前"
  end
end
