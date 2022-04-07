# frozen_string_literal: true

class DoneButtonComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(repetitive_task:)
    @repetitive_task = repetitive_task
  end

  def label
    done_today? ? 'やった！' : 'やった？'
  end

  def http_method
    done_today? ? :delete : :post
  end

  def done_or_undone_path
    done_today? ? undone_path : done_path
  end

  def done_today?
    @repetitive_task.done_today?
  end

  private

  def done_path
    repetitive_task_repetitive_task_logs_path(@repetitive_task)
  end

  def undone_path
    repetitive_task_repetitive_task_log_path(@repetitive_task.id, @repetitive_task.today_log.id)
  end
end