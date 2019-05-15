ActiveJob::Base.queue_adapter = :sidekiq

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379', namespace: "mrbitcoin" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379', namespace: "mrbitcoin" }
end
