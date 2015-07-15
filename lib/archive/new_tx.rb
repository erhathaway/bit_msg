require 'bitcoin'
require 'open-uri'
require 'pry'


# Bitcoin.network = :testnet3

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
priv_key    = "bf785a9fc71fd4319714766ab4a37e9339c66a878cf5826ea7dc593c9b89b62f"
publ_key    = "044a1cf886db82121d18a6732f618c6febe4082596ccc24663bd3d7e318b1dff6def25ca9afaec6c2f6e4bae6f1a748c18e5620b536aeff07343ad91638d589801"
address     = "13WXAwtPUMFXnhULmN9K5L6Mx7JwvznVSi"
previous_tx = "dc67dadf5312b205b9dd8475abdbc441f36710ba4abfa68679abfe116a17ae63"

# generate tx info off inputs
key             = Bitcoin::Key.new(priv_key, publ_key)
prev_tx         = prev_tx(previous_tx, "bitcoin")
prev_tx_output_index  = 0
value        = prev_tx.outputs[prev_tx_output_index].value


tx = Bitcoin::P::Tx.new
# binding.pry
tx.add_in Bitcoin::P::TxIn.new(prev_tx.binary_hash, prev_tx_output_index, 0)
# binding.pry
tx.add_out Bitcoin::P::TxOut.value_to_address(value, address) # <- dest address (our donation address)
# binding.pry
# if all in and outputs are defined, start signing inputs.
key = Bitcoin.open_key(priv_key) # <- privkey
sig = Bitcoin.sign_data(key, tx.signature_hash_for_input(0, prev_tx))
tx.in[0].script_sig = Bitcoin::Script.to_signature_pubkey_script(sig, [key.public_key_hex].pack("H*"))
tx.in[0].add_signature_pubkey_script(sig, key.public_key_hex)


# finish check
tx = Bitcoin::Protocol::Tx.new( tx.to_payload )
p tx.hash
p tx.verify_input_signature(0, prev_tx) == true

puts "json:\n"
puts tx.to_json # json
puts "\nhex:\n"
puts tx.to_payload.unpack("H*")[0] # hex binary

# # use this json file for example with `ruby simple_network_monitor_and_util.rb send_tx=<filename>` to push/send it to the network
# File.open(tx.hash + ".json", 'wb'){|f| f.print tx.to_json }