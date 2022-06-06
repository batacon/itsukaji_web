# frozen_string_literal: true

require 'uri'
require 'net/http'

class CreateNotification
  def initialize(contents:, user_id:)
    @contents = contents
    @user_id = user_id
  end

  def call
    url = URI('https://onesignal.com/api/v1/notifications')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request['Accept'] = 'application/json'
    request['Authorization'] = "Basic #{Rails.application.credentials.one_signal[:rest_api_key]}"
    request['Content-Type'] = 'application/json'
    request.body = {
      app_id: Rails.application.credentials.one_signal[:app_id],
      include_external_user_ids: [@user_id.to_s],
      contents: @contents
    }.to_json
    puts '************▼OneSignal request▼************'
    puts request
    puts '************▲OneSignal request▲************'
    response = http.request(request)
    puts '************▼OneSignal response▼************'
    puts response.read_body
    puts '************▲OneSignal response▲************'
  end
end