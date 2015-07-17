require_relative '../bitcoin/new_blocks.rb'


namespace :scheduler do

  desc "This task is called by the Heroku scheduler add-on"

  task :get_new_blocks => :environment do
    puts "Getting new blocks from blockchain..."

    #compare current block chain to db data
    btc_current_height = get_latest_height
    db_current_height = Block.maximum(:block_height).to_i

    #get header and next block height info for current blockchain
    block_header = get_block_header(btc_current_height)
    nb = get_block_header_nb(block_header)
    next_nb = check_block_header_newness(block_header)
    binding.pry

    if btc_current_height != db_current_height + 1
      block_header = get_block_header(db_current_height + 1)
      nb = get_block_header_nb(block_header)
      next_nb = check_block_header_newness(block_header)
    end

    #check if block is in database
    if not Block.exists?(block_height: nb)
      # write block to database
      puts "adding block to db!"
    end

    #if current block header data is old
    while next_nb != false
      block_header = get_block_header(next_nb)
      nb = get_block_header_nb(block_header)
      next_nb = check_block_header_newness(block_header)
      #check if block is in database
      if not Block.exists?(block_height: nb)
        # write block to database
        puts "adding block to db!"
      end
      binding.pry
    end

  end

  task :update_message_feed => :environment do

  end

end
