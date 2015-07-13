require 'bitcoin'
require 'pry'


def new_address
  private_key, public_key = Bitcoin::generate_key
  address = Bitcoin::pubkey_to_address(public_key)
  [private_key, public_key, address]
end

def key_details(prikey, pubkey)
  #returns prikey, prikey_hash58, pubkey_hash58, pubkey_uncompressed, address as a hash
  my_key = Bitcoin::Key.new(prikey, pubkey)
  { prikey:prikey, 
    prikey_base58:my_key.to_base58, 
    pubkey_58:my_key.hash160, 
    pubkey: my_key.pub_uncompressed, 
    address:my_key.addr
  }
end

def prikey_from58(prikey_58)
  my_key = Bitcoin::Key.from_base58(prikey_58)
  { prikey:my_key.priv, 
    prikey_base58:my_key.to_base58, 
    pubkey_58:my_key.pub, 
    pubkey: my_key.pub_uncompressed, 
    address:my_key.addr
  }
end

