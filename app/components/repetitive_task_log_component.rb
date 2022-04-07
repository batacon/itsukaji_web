# frozen_string_literal: true

class RepetitiveTaskLogComponent < ViewComponent::Base
  def initialize(repetitive_task_log:)
    @repetitive_task_log = repetitive_task_log
  end
end
