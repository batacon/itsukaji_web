# frozen_string_literal: true

class StaticPagesController < ApplicationController
  skip_before_action :check_logged_in, only: :privacy_policy

  def privacy_policy; end
end
