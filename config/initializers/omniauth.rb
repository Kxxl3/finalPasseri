Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, :google if Rails.env.development?
  end