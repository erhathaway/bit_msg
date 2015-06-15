require 'bitcoin'

require 'pry'

# ------------------------------------------------
# #  TEST: bitcoin-ruby gem------------
# ------------------------------------------------

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


###Make New Transactions
#use TX information to create new TX

# ------------------------------------------------


def prepare_transaction()
end

def pack_message(message)
end

def send_message(transaction, packed_message)
end

