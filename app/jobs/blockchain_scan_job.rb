#enqued with code in config/initializers/active_job.rb

class BlockchainScanJob < ActiveJob::Base
  queue_as :default

  def perform()
    # Do something later
    puts "hi!!"

    self.class.perform_later(wait: 10.minutes)
  end
end
