# require 'blockchain'
#using the blockchain API

# stats = Blockchain::get_statistics()

	  # @blocks_size                       @mined_blocks            @total_blocks    
	  # @btc_mined                         @miners_revenue_btc      @total_btc       
	  # @difficulty                        @miners_revenue_usd      @total_btc_sent  
	  # @estimated_btc_sent                @minutes_between_blocks  @total_fees_btc  
	  # @estimated_transaction_volume_usd  @next_retarget           @trade_volume_btc
	  # @hash_rate                         @number_of_transactions  @trade_volume_usd
	  # @market_price_usd                  @timestamp     


# address = Blockchain::get_address('16mnnKSG8dMoehGekQgvnWVGtaoxnNV182')

	  # @address        @hash160  @total_received  @transactions
	  # @final_balance  @n_tx     @total_sent    

# transactions = address.transactions[0].hash
# puts transactions

# tx = Blockchain::get_tx(transactions)

	 # @relayed_by  		@size
	 # @time 				@tx_index
	 # @version  			@block_height
	 # @double_spend 		@hash
	 # @inputs 				@outputs


# outputs = address.transactions[0].outputs
# inputs = address.transactions[0].inputs

    # @address    			@n
    # @script    			@script_sig
    # @sequence    			@tx_index
    # @type    				@value

