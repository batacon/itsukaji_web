# frozen_string_literal: true

require 'uri'
require 'net/http'

class CreateNotification
  URL = URI('https://onesignal.com/api/v1/notifications')

  def initialize(contents:, target_user_ids:)
    @contents = contents
    @target_user_ids = target_user_ids.map(&:to_s)
  end

  def call
    http = Net::HTTP.new(URL.host, URL.port)
    http.use_ssl = true
    response = http.request(onesignal_request)
    puts '************▼OneSignal response▼************'
    puts response.read_body
    puts '************▲OneSignal response▲************'
  end

  private

  def onesignal_request
    request = Net::HTTP::Post.new(URL)
    request['Accept'] = 'application/json'
    request['Authorization'] = "Basic #{Rails.application.credentials.one_signal[:rest_api_key]}"
    request['Content-Type'] = 'application/json'
    request.body = {
      app_id: Rails.application.credentials.one_signal[:app_id],
      include_external_user_ids: @target_user_ids,
      contents: @contents
    }.to_json
    puts '************▼OneSignal request▼************'
    puts request.body
    puts '************▲OneSignal request▲************'
    request
  end
end
