class TestJob < ActiveJob::Base
  queue_as :default

  def perform()
    # Do something later
    # binding.pry
    puts "hiiiiiiiiiiiiiiiiiiii"
  end
end
