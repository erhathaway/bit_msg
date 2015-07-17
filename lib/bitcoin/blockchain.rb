# require 'rubygems'
# require 'blockchain'
# require 'pry'
# require 'httparty'
# require 'json'
#using the blockchain API

def get_available_transactions(address, network='bitcoin')
  available_transactions = {}

  if network == 'testnet3'
    response = HTTParty.get("http://test.webbtc.com/address/#{address}.json")
    transactions = response["transactions"]
    transactions.each do |k,v|
      tx_hash = k
      tx = v
      outputs = tx["out"]
      counter = 0
      outputs.each do |o|
        if o["address"] == address
          available_transactions[tx_hash]=counter
        end
        counter +=1
      end
    end
  elsif network == 'bitcoin'
    address_obj = Blockchain::get_address(address)
    transactions = address_obj.transactions

    transactions.each do |t|
      counter = 0

      t.outputs.each do |o|
        if o.address == address and o.spent == false
          available_transactions[t.hash]=counter
        end
        counter +=1
      end
    end
  end
  available_transactions
end


def get_tx_obj(prev_hash, network)
  if network == "testnet3"
    prev_tx = Bitcoin::P::Tx.from_json(open("http://test.webbtc.com/tx/#{prev_hash}.json"))
  else
    prev_tx = Bitcoin::P::Tx.from_json(open("http://webbtc.com/tx/#{prev_hash}.json"))
  end
end

def get_all_transactions(address, network='bitcoin')
  transactions = []

  if network == 'testnet3'
    response = HTTParty.get("http://test.webbtc.com/address/#{address}.json")
    transactions = response["transactions"]
  elsif network == 'bitcoin'
    response = HTTParty.get("http://webbtc.com/address/#{address}.json")
    transactions = response["transactions"]
  end
  transactions
end



# transactions = get_all_transactions("16mnnKSG8dMoehGekQgvnWVGtaoxnNV182")
# puts JSON.pretty_generate(transactions)
