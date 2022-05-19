# frozen_string_literal: true

class SearchFormComponent < ViewComponent::Base
  def initialize
    @submit = raw 'document.getElementById("search-submit").click();'
  end
end
