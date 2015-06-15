# bit_msg
zero-knowledge (client-side encryption) p2p messaging using bitcoin blockchain

About:
- This project uses a javascript client-side AES 128 bit encryption library to encode messages locally in the user's browser. 
 - The user enters a password, secret message, and ID for the message
 - The user has the option to salt the password or change the default encryption parameters
 - When the user hits 'encrypt' they see the ciphertext and related encryption data
- After encrypting a message, the user can submit the message to the server
- The server:
 - Sends bitcoin transactions back and forth between two addresses
 - It does this by: 
  - Finding which address has the most money (was most recently sent a message)
  - Creating a new micro bitcoin transaction (~5 cents) and encodes the ID and ciphertext in the OP_RETURN field
  - Submiting the transaction to the bitcoin network
- A user can find encrypted messages on the block chain by going to the site and entering a message ID. 
 - This downloads all bitcoin OP_RETURN data that contains the ID
 - The user can enter a password, alter any encryption parameters (if custom ones were used), and see if any of the downloaded data gets decoded into meaningful messages
