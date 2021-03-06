require_relative '../bitcoin/new_blocks.rb'
require_relative '../bitcoin/utilities.rb'
def add_block(block_header)
  begin
    a = Block.new
    a.add_block_header(block_header)
    a.save
  rescue
    puts "error in adding block to database"
  end
  a
end

def add_messages_and_transactions(block_obj)
  begin
    block = get_block_by_hash(block_obj.block_hash)
    messages = get_op_returns(block)
    messages.each do |k,v|
      begin
        t = Exchange.find_or_create_by(exchange_hash: k, block_id: block_obj.id)
        Message.create(
          exchange_id: t.id,
          op_return_data_raw: v,
          op_return_data_decoded: decode_message(v))
      rescue
        "error parsing message data"
      end
    end
  rescue
    puts "error parsing block and creating messages / transaction data"
  end
end


namespace :scheduler do

  desc "This task is called by the Heroku scheduler add-on"

  task :get_new_blocks => :environment do
    puts "Getting new blocks from blockchain..."
    begin
      #compare current block chain to db data
      btc_current_height = get_latest_height
      db_current_height = Block.maximum(:block_height).to_i

      #get header and next block height info for current blockchain
      block_header  = get_block_header(btc_current_height)
      nb            = get_block_header_nb(block_header)
      next_nb       = check_block_header_newness(block_header)


      if btc_current_height != db_current_height + 1
        block_header  = get_block_header(db_current_height + 1)
        nb            = get_block_header_nb(block_header)
        next_nb       = check_block_header_newness(block_header)
      end

      #check if block is in database
      if not Block.exists?(block_height: nb)
        # write block to database
        puts "adding block to db!"
        block = add_block(block_header)
        add_messages_and_transactions(block)
      end

      #if current block header data is old
      while next_nb != false
        block_header  = get_block_header(next_nb)
        nb            = get_block_header_nb(block_header)
        next_nb       = check_block_header_newness(block_header)
        #check if block is in database
        if not Block.exists?(block_height: nb)
          # write block to database
          puts "adding block to db!"
          block = add_block(block_header)
          add_messages_and_transactions(block)
        end
      end
    rescue StandardError=>e
      puts "Error: #{e}"
      puts "ERROR in downloading newest blockchain data"
      puts "#lib/tasks/scheduler.rake"

    end

  end

  task :update_message_feed => :environment do

  end

end
