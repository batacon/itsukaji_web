# frozen_string_literal: true

class RepetitiveTaskFormComponent < ViewComponent::Base
  def initialize(repetitive_task:)
    @repetitive_task = repetitive_task
  end

  def for_create?
    @repetitive_task.new_record?
  end
end
