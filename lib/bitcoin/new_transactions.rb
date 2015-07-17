# require 'rubygems'
# require 'blockchain'
# require 'pry'
# # require 'httparty'
# require 'json'
# require_relative 'utilities.rb'

# https://blockexplorer.com/q

def get_newest_block
  # block_hash = HTTParty.get("https://blockexplorer.com/q/latesthash")
  latest_block = HTTParty.get("http://btc.blockr.io/api/v1/block/info/365450")
  block_hash = latest_block["data"]["hash"]
  block = HTTParty.get("http://webbtc.com/block/#{block_hash}.json")
end


def get_block_by_height(height)
  block_data = HTTParty.get("http://btc.blockr.io/api/v1/block/info/#{height}")
  block_hash = block_data["data"]["hash"]
  block = HTTParty.get("http://webbtc.com/block/#{block_hash}.json")
end

def parse_op_return(op_data)
  op_data.split(" ")[1]
end

def get_op_returns(block)
  op_return_transactions = {}
  transactions = block["tx"]
  transactions.each do |t|
    outputs = t["out"]
    outputs.each do |o|
      op_data = o["scriptPubKey"].downcase
      if op_data.include? "op_return"
        tx_hash = t["hash"]
        hex_message = parse_op_return(op_data)
        op_return_transactions[tx_hash] = hex_message
      end
    end
  end
  op_return_transactions
end

# example usage
# ----------------------------
# block = get_newest_block
# puts get_op_returns(block)


# [365446,365447,365448,365449,365450].each do |height|
#   block = get_block_by_height(height)
#   puts get_op_returns(block)
# end

# example results
# ----------------------------
# {"45f8f7d80413b9939dbbac72987ab2c71f71d09e3b2ab8c2e8a2403ad042cbaf"=>"4f41010001f40318753d68747470253341253246253246626f6f702e626f6f70", "11b130f691bd196b543ecef3e2556bfea47df03328bf30f315277ac79826b7ab"=>"4f41010001f40300", "a6ec5566f07e1fc0b3e8dabf405858a9b18c4d808cd7835458204f397d68cedc"=>"4f41010001f40300"}
# {}
# {}
# {"4b706dcf69a7f0dea78c071c672e17f7c344c2b66d9cd040ecc8d411ad201f1e"=>"4f41010001f40318753d68747470253341253246253246626f6f702e626f6f70", "24cf377fbc9b6079d8ce30559551d252f89dc814f85662c8fa0f33a14de7ba35"=>"4f41010001f40300", "3845f9ab4151a80c372a7043ed086f676029c28085ea70f6bd8ba7fcd1851237"=>"4f41010001f40300"}
# {"ab26fbeb86f5dfc7cbbbc19cc311385e771c22de032600592e3562acadc54be2"=>"4f410100010a00"}

# puts decode_message("4f41010001f40300")
