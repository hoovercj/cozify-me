Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Rails.application.secrets.github_key || ENV["GITHUB_KEY"], Rails.application.secrets.github_secret || ENV["GITHUB_SECRET"]
end