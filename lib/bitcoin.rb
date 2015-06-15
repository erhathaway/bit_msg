require 'bitcoin'
require_relative 'blockchain'
require "open-uri"
require 'pry'
require 'json'

###Create Address:
###++++++++++++++++++++++++++
## http://www.rubydoc.info/github/lian/bitcoin-ruby/Bitcoin/Key#priv-instance_method
# #Note: generate_key seems to geneate a public key that is incorrect. 
# key = Bitcoin::generate_key
# #To get around this, take the private key (key[0]) and instantiate a new Key object
# my_key = Bitcoin::Key.new(key[0])
# pubkey =  my_key.pub
# address = my_key.addr
# prikey_base56 = my_key.to_base58 #this is how some wallets store the private key (esp MultiBit)

def new_prikey
	Bitcoin::generate_key[0]
end

def key_details(prikey)
	#returns hash58, pubkey, address as a hash
	my_key = Bitcoin::Key.new(prikey)
	{prikey:prikey, prikey_base58:my_key.to_base58, pubkey:my_key.pub, address:my_key.addr}
end


###Get Transaction Info:
###++++++++++++++++++++++++++
# 'https://blockchain.info/rawtx/dc67dadf5312b205b9dd8475abdbc441f36710ba4abfa68679abfe116a17ae63?format=json'
# 'http://webbtc.com/tx/dc67dadf5312b205b9dd8475abdbc441f36710ba4abfa68679abfe116a17ae63.json'

# https://github.com/blockchain/api-v1-client-ruby/blob/master/docs/blockexplorer.md

# >> see blockchain.rb


	
def send_message(message, prev_hash, to_address, from_address, private_key)

	Bitcoin.network = :testnet3

	include Bitcoin::Builder

	prev_out_index = 0

	prev_tx = Bitcoin::P::Tx.from_json(open("http://webbtc.com/tx/#{prev_hash}.json"))


	key = Bitcoin::Key.new(private_key)

	# send the same amount as the last tranasction
	value = prev_tx.outputs[prev_out_index].value

	new_tx = build_tx do |t|

	  # add the input you picked out earlier
	  t.input do |i|
	    i.prev_out prev_tx
	    i.prev_out_index prev_out_index
	    i.signature_key key
	  end

	  # add an output that sends some bitcoins to another address
	  t.output do |o|
	    o.value value # amount to send to recipent address
	    o.script {|s| s.recipient to_address }
	  end

	  # add another output spending the remaining amount back to yourself
	  # if you want to pay a tx fee, reduce the value of this output accordingly
	  # if you want to keep your financial history private, use a different address
	  t.output do |o|
	    o.value value #Any difference between this and other value is a BTC Miner fee
	    o.script {|s| s.recipient from_address }
	  end

	  t.output do |o|
	    # specify message to encodue using OP_RETURN    
	    o.to message, :op_return
	   	# o.to message.unpack("H*"), :op_return

	    # specify the value of this output (zero)
	    o.value 0
	  end

	end

	# format tx to hex and json 
	hex_tx = new_tx.to_payload.unpack("H*")[0]

	json_tx =  new_tx.to_json

	[hex_tx, json_tx]
end 


message 		= 'feNxzxHyGtW4XCOCUsPtDB0N+m6ModAp6H/3APjfNB4uPeDzuOZ8'
prev_hash 		= 'dc67dadf5312b205b9dd8475abdbc441f36710ba4abfa68679abfe116a17ae63'
to_address  	= ''
from_address 	= ''
private_key 	= ''


send_message(message, prev_hash, to_address, from_address, private_key )



