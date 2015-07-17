require_relative '../bitcoin/new_transactions.rb'


namespace :scheduler do

  desc "This task is called by the Heroku scheduler add-on"

  task :fetch_new_tranactions => :environment do
    puts "Getting new block..."
    block = get_newest_block
    puts block
  end

  task :update_message_feed => :environment do

  end

end
