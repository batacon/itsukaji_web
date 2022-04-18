# frozen_string_literal: true

class RepetitiveTaskComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(repetitive_task:)
    @repetitive_task = repetitive_task
  end
end
