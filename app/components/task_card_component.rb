# frozen_string_literal: true

class TaskCardComponent < ViewComponent::Base
  def initialize(repetitive_task:)
    @repetitive_task = repetitive_task
  end

  def edit_path
    edit_repetitive_task_path(@repetitive_task)
  end

  def interval_days_number
    @repetitive_task.interval_days
  end

  def day_or_days
    interval_days_number > 1 ? 'days' : 'day'
  end

  def task_name
    @repetitive_task.name
  end

  def should_do_today?
    @repetitive_task.should_do_today?
  end

  def done_at_least_once
    !@repetitive_task.never_done?
  end

  def calendar_check_icon
    should_do_today? ? 'icon_calendar_check_red.svg' : 'icon_calendar_check_blue.svg'
  end

  def bell_icon
    should_do_today? ? 'icon_bell_red.svg' : 'icon_bell_blue.svg'
  end

  def last_done_at
    I18n.localize(@repetitive_task.last_done_at)
  end

  def days_until_next
    @repetitive_task.days_until_next
  end
end
