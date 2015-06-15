# bit_msg
zero-knowledge (client-side encryption) p2p messaging using bitcoin blockchain

About:
- This project uses a javascript client-side AES 128 bit encryption library to encode messages locally in the users browser. 
 - The user enters a password, secret message, and ID for the message
 - The user has the option to salt the password or change the default encryption parameters
 - When the user hits 'encrypt' they see the ciphertext and related encryption data
- After encrypting a message, the user can submit the message to the server
- The server:
 - Creates a new micro bitcoin transaction (~5 cents) and encodes the ID and ciphertext in the OP_RETURN field
 - Submits the transaction to the bitcoin network
- A user can find encrypted messages on the block chain by going to the site and entering a message ID. 
 - This downloads all bit-coin OP-RETURN data that contains the ID
 - The user can enter a password, alter any encryption parameters (if custom ones were used), and see if any of the downloaded data gets decoded into meaningful messages
