# frozen_string_literal: true

class RepetitiveTaskListComponent < ViewComponent::Base
  def initialize(repetitive_tasks:)
    @repetitive_tasks = repetitive_tasks
  end
end
