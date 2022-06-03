# frozen_string_literal: true

module Loggable
  extend ActiveSupport::Concern

  included do
    has_one :activity_log, as: :loggable, touch: true, dependent: :destroy
  end

  # 別のモジュールに分けるべきかもしれない
  def bold(text)
    "<span class=\"font-bold\">#{text}</span>"
  end
end
