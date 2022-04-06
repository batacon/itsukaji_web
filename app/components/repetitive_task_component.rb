# frozen_string_literal: true

class RepetitiveTaskComponent < ViewComponent::Base
  def initialize(repetitive_task:)
    @repetitive_task = repetitive_task
  end
end
