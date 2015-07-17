# require "#{Rails.root}/lib/bitcoin/blockchain.rb"


namespace :my_namespace do
  desc "TODO"
  task my_task1: :environment do
    binding.pry
    Rake.application.rake_require "#{Rails.root}/lib/bitcoin/blockchain.rb"

  end

  desc "TODO"
  task my_task2: :environment do
  end

end
