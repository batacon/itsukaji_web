# frozen_string_literal: true

class RepetitiveTaskLogComponent < ViewComponent::Base
  def initialize(repetitive_task_log:)
    @repetitive_task_log = repetitive_task_log

    @form_target = [repetitive_task_log.repetitive_task, repetitive_task_log]
    @form_submit_id = "log-form-submit-#{repetitive_task_log.id}"
  end

  private

  def next_date_of_previous_log
    return if @repetitive_task_log.previous_log_date.nil?

    @repetitive_task_log.previous_log_date + 1
  end

  def previous_date_of_next_log
    return Date.today if @repetitive_task_log.next_log_date.nil?

    @repetitive_task_log.next_log_date - 1
  end

  def how_many_days_ago
    days_number = @repetitive_task_log.how_many_days_ago
    days_number.zero? ? '(今日)' : "(#{days_number}日前)"
  end
end
