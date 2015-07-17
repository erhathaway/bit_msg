#sudo apt-get install redis-server
#redis-server &

Rails.application.config.active_job.queue_adapter = :sidekiq


TestJob.set(wait: 1.minutes).perform_later("hi")
