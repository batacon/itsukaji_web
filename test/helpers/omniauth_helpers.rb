module OmniAuthHelpers
  setup do
    OmniAuth.config.test_mode = true
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
  end

  teardown do
    OmniAuth.config.test_mode = false
  end

  def google_oauth2_mock
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: "google_oauth2",
      uid: "12345678910",
      info: {
        email: "test@example.com",
        name: "Test User",
      }
    })
  end
end
