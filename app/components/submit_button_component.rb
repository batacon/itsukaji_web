# frozen_string_literal: true

class SubmitButtonComponent < ViewComponent::Base
  def initialize(form:, label:)
    @form = form
    @label = label
  end
end
