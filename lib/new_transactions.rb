require 'rubygems'
require 'blockchain'
require 'pry'
require 'httparty'
require 'json'

# https://blockexplorer.com/q

block_hash = HTTParty.get("https://blockexplorer.com/q/latesthash")
# block_hash = "000000000000000004b33312824bb8ae1b5249fc9aa5d42d1771e258ea0e8b59"
block = HTTParty.get("http://webbtc.com/block/#{block_hash}.json")


def get_op_returns(block)
  op_return_transactions = {}

  transactions = block["tx"]
  transactions.each do |t|
    outputs = t["out"]
    outputs.each do |o|
      op_data = o["scriptPubKey"].downcase
      if op_data.include? "op_return"
        tx_hash = t["hash"]
        op_return_transactions[tx_hash] = op_data
      end
    end
  end
  op_return_transactions
end

puts get_op_returns(block)
# str = "1e5580".pack("H*")
# puts str
# puts "hello".unpack('H*')
