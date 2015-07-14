require 'bitcoin'
require_relative 'utilities.rb'
require_relative 'wallet.rb'
require_relative 'blockchain.rb'
require 'open-uri'
require 'json'
require 'pry'

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
      o.script { |s| s.type :address; s.recipient addr }
      # o.script {|s| s.recipient key.addr }
    end

    t.output do |o|
      o.to message, :op_return
      o.value 0
    end

  end
end

#transaction inputs
# ------------------------------------------------
in_wallet_number = 1
out_wallet_number = 2
network = "bitcoin"

in_priv_key    = wallet[in_wallet_number][:priv_key]
in_publ_key    = wallet[in_wallet_number][:publ_key]
in_address     = wallet[in_wallet_number][:address]
out_address    = wallet[out_wallet_number][:address]

# generate tx info off inputs
# ------------------------------------------------

if network == "testnet3"
  Bitcoin.network = :testnet3
elsif network == "bitcoin"
  Bitcoin.network = :bitcoin
end
  
previous_tx     = "no transaction found"
prev_out_index = 0

# transactions = get_all_transactions(in_address, network)
# puts in_address
# puts JSON.pretty_generate(transactions)

# previous_tx = "a6594864986d83b70b0f9a04d6a72d28d493e886f9cef3b00d20bd13d4c2a7f7"
# prev_out_index = 1
previous_tx = "dc67dadf5312b205b9dd8475abdbc441f36710ba4abfa68679abfe116a17ae63"
prev_out_index = 0

# get_available_transactions(in_address, network).each do |output|
#   previous_tx    = output[0]
#   prev_out_index = output[1]
# end

key             = get_key(in_priv_key, in_publ_key, in_address)
prev_tx         = get_tx_obj(previous_tx, network)

tx_value        = prev_tx.outputs[prev_out_index].value - 10000

# print state
# ------------------------------------------------
print_state(
  in_priv_key,
  in_publ_key, 
  in_address,
  key,
  out_address,
  previous_tx,
  tx_value,
  prev_out_index)

# build new tx
# ------------------------------------------------
tx = build_transaction(prev_tx, prev_out_index, key, tx_value, out_address, "hello")

puts tx.to_json
puts
puts bin_to_hex(tx.to_payload)


