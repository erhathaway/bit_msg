# require 'rubygems'
# require 'bitcoin'
# require_relative 'blockchain'
# require "open-uri"
# require 'pry'
# require 'json'

###Create Address:
###++++++++++++++++++++++++++
## http://www.rubydoc.info/github/lian/bitcoin-ruby/Bitcoin/Key#priv-instance_method
# #Note: generate_key seems to geneate a public key that is incorrect. 
# key = Bitcoin::generate_key
# #To get around this, take the private key (key[0]) and instantiate a new Key object
# my_key = Bitcoin::Key.new(key[0])
# pubkey =  my_key.pub
# address = my_key.addr
# prikey_base58 = my_key.to_base58 #this is how some wallets store the private key (esp MultiBit)

###Get Transaction Info:
###++++++++++++++++++++++++++
# https://github.com/blockchain/api-v1-client-ruby/blob/master/docs/blockexplorer.md

# >> see blockchain.rb

# ###Get Transaction Info:
# ###++++++++++++++++++++++++++
# # 'https://blockchain.info/rawtx/dc67dadf5312b205b9dd8475abdbc441f36710ba4abfa68679abfe116a17ae63?format=json'
# # 'http://webbtc.com/tx/dc67dadf5312b205b9dd8475abdbc441f36710ba4abfa68679abfe116a17ae63.json'

# # https://github.com/blockchain/api-v1-client-ruby/blob/master/docs/blockexplorer.md

# # >> see blockchain.rb


	
# def send_message(message, prev_hash, private_key1, private_key2)

# 	Bitcoin.network = :testnet3
# 	# Bitcoin.network = :bitcoin

# 	include Bitcoin::Builder

# 	prev_out_index = 0

# 	prev_tx = Bitcoin::P::Tx.from_json(open("http://webbtc.com/tx/#{prev_hash}.json"))


# 	key = Bitcoin::Key.new(private_key1)
# 	to_key = Bitcoin::Key.new(private_key2)
# 	to_address=to_key.addr

# 	# send the same amount as the last tranasction
# 	value = prev_tx.outputs[prev_out_index].value

# 	new_tx = build_tx do |t|

# 	  # add the input you picked out earlier
# 	  t.input do |i|
# 	    i.prev_out prev_tx
# 	    i.prev_out_index prev_out_index
# 	    i.signature_key key 
# 	  end

# 	  # add an output that sends some bitcoins to another address
# 	  t.output do |o|
# 	    o.value value # amount to send to recipent address
# 	          # o.script {|s| s.type :address; s.recipient addr }
# 	    o.script {|s| s.recipient to_address }
# 	  end

# 	  # add another output spending the remaining amount back to yourself
# 	  # if you want to pay a tx fee, reduce the value of this output accordingly
# 	  # if you want to keep your financial history private, use a different address
# 	  # t.output do |o|
# 	  #   o.value value #Any difference between this and other value is a BTC Miner fee
# 	  #   o.script {|s| s.recipient key.addr }
# 	  # end

# 	  t.output do |o|
# 	    # specify message to encodue using OP_RETURN    
# 	    o.to message, :op_return
# 	   	# o.to message.unpack("H*"), :op_return

# 	    # specify the value of this output (zero)
# 	    o.value 0
# 	  end

# 	end

# 	# format tx to hex and json 
# 	hex_tax = new_tx.to_payload.unpack("H*")[0]

# 	json_tx =  new_tx.to_json

# 	[hex_tx, json_tx]
# end 

# message 		= 'hello world!'
# prev_hash 		= 'dc67dadf5312b205b9dd8475abdbc441f36710ba4abfa68679abfe116a17ae63'
# private_key2  	= 'dac07eefcf6a35186c2e4e399810885430c085391e382290b95473cd861497c1'
# private_key1 	= 'bf785a9fc71fd4319714766ab4a37e9339c66a878cf5826ea7dc593c9b89b62f'


# # puts send_message(message, prev_hash, private_key1, private_key2 )


# # puts Bitcoin::valid_address?(to_address)

# # puts key_details(new_prikey)