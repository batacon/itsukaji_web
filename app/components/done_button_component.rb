# frozen_string_literal: true

class DoneButtonComponent < ViewComponent::Base
  def initialize(repetitive_task:)
    @repetitive_task = repetitive_task
  end

  private

  def done_button_image
    return 'balloon_blue_done.svg' if done_today?

    @repetitive_task.should_do_today? ? 'balloon_red_yet.svg' : 'balloon_blue_yet.svg'
  end

  def done_or_undone_path
    done_today? ? undone_path : done_path
  end

  def post_or_delete
    done_today? ? :delete : :post
  end

  def done_today?
    @repetitive_task.done_today?
  end

  def done_path
    repetitive_task_repetitive_task_logs_path(@repetitive_task)
  end

  def undone_path
    repetitive_task_repetitive_task_log_path(@repetitive_task.id, @repetitive_task.today_log.id)
  end
end
