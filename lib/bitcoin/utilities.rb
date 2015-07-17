# require 'bitcoin'
# require 'pry'

# comment in if using the test network
# Bitcoin.network = :testnet3

def new_address
  private_key, public_key = Bitcoin::generate_key
  address = Bitcoin::pubkey_to_address(public_key)
  [private_key, public_key, address]
end

def key_details(prikey, pubkey)
  #returns prikey, prikey_hash58, pubkey_hash58, pubkey_uncompressed, address as a hash
  my_key = Bitcoin::Key.new(prikey, pubkey)
  { priv_key:prikey,
    priv_key_58:my_key.to_base58,
    publ_key_160:my_key.hash160,
    publ_key: my_key.pub_uncompressed,
    address:my_key.addr
  }
end

def prikey_from58(prikey_58)
  my_key = Bitcoin::Key.from_base58(prikey_58)
  { priv_key:my_key.priv,
    priv_key_58:my_key.to_base58,
    publ_key_160:my_key.pub,
    publ_key: my_key.pub_uncompressed,
    address: my_key.addr
  }
end

def get_key(priv_key, publ_key, addr)
  key = Bitcoin::Key.new(priv_key, publ_key)
  if key.addr == addr
    return key
  else
    return Bitcoin::Key.new(priv_key)
  end
end

def print_state(in_priv, in_pub, in_addr, key, out_addr, in_tx_hash, in_tx_value, in_tx_index, message="")
  puts "Private key:       " + in_priv
  puts "Public key:        " + in_pub
  puts "Tx input address:  " + in_addr
  puts "Key address:       " + key.addr
  puts "Tx output address: " + out_addr
  puts "Tx input hash:     " + in_tx_hash
  puts "Tx input value:    " + in_tx_value.to_s
  puts "Tx input index:    " + in_tx_index.to_s
  puts "Message:           " + encode_message(message).join()
  puts "Message length:    " + encode_message(message).join().length.to_s
  puts
end

def bin_to_hex(s)
  s.unpack('H*').first
end

def encode_message(message)
  message.unpack("H*")
end

def decode_message(message)
  s = [message].pack("H*")
  a = s.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
  a.gsub("\u0000", '')
end
