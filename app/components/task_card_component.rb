# frozen_string_literal: true

class TaskCardComponent < ViewComponent::Base
  def initialize(repetitive_task:)
    @repetitive_task = repetitive_task

    @task_name = repetitive_task.name
    @calendar_check_icon = should_do_today? ? 'icon_calendar_check_red.svg' : 'icon_calendar_check_blue.svg'
    @bell_icon = should_do_today? ? 'icon_bell_red.svg' : 'icon_bell_blue.svg'
    @days_until_next = should_do_today? ? 'やりましょう' : "あと #{repetitive_task.days_until_next}日"
  end

  private

  def edit_path
    edit_repetitive_task_path(@repetitive_task)
  end

  def every_interval_days
    interval_days = @repetitive_task.interval_days
    interval_days > 1 ? "every #{interval_days} days" : 'every day'
  end

  def should_do_today?
    @repetitive_task.should_do_today?
  end

  def done_at_least_once?
    !@repetitive_task.never_done?
  end

  def last_done_at
    I18n.localize(@repetitive_task.last_done_at)
  end
end
