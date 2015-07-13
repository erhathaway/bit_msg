require 'bitcoin'
require_relative 'utilities.rb'
require 'open-uri'

Bitcoin.network = :testnet3

def build_transaction(prev_tx, prev_out_index, key, value, addr, message)

  include Bitcoin::Builder
  new_tx = build_tx do |t|

    t.input do |i|
      i.prev_out prev_tx
      i.prev_out_index prev_out_index
      i.signature_key key
    end

    t.output do |o|
      o.value value 

      o.script { |s| binding.pry s.type :address; s.recipient addr }
      # o.script {|s| s.recipient key.addr }
    end

    t.output do |o|
      o.to message, :op_return
      o.value 0
    end

  end
end

def prev_tx(prev_hash, network)
  if network == "testnet3"
    prev_tx = Bitcoin::P::Tx.from_json(open("http://test.webbtc.com/tx/#{prev_hash}.json"))
  else
    prev_tx = Bitcoin::P::Tx.from_json(open("http://webbtc.com/tx/#{prev_hash}.json"))
  end
end

def key(publ_key, priv_key)
  key = Bitcoin::Key.new(priv_key, publ_key)
end

def bin_to_hex(s)
  s.unpack('H*').first
end

#transaction inputs
priv_key    = "private key"
publ_key    = "uncompressed public key"
address     = "1MrEdc7ee7Kop4ZptE3222KzhqDTQa2epR"
previous_tx = "66c82ddda2ddb1789c8fb28ef4913d05f3fa7f2ef9841c9c8115f6b98729e14d"

# generate tx info off inputs
key             = Bitcoin::Key.new(priv_key, publ_key)
prev_tx         = prev_tx(previous_tx, "testnet3")
prev_out_index  = 1
tx_value        = prev_tx.outputs[prev_out_index].value

# build new tx
tx = build_transaction(prev_tx, prev_out_index, key, tx_value, address, "hello")

# puts tx.to_json
puts bin_to_hex(tx.to_payload)







