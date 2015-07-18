class Message < ActiveRecord::Base
  belongs_to :exchange
  belongs_to :block
  belongs_to :message_tag
  has_many :message_metadata

  validates :op_return_data_raw, presence: true
  validates :op_return_data_decoded, presence: true

  # paginates_per 50

  # def self.search(search)
  #   where("common_name ILIKE :search OR scientific_name ILIKE :search",
  #        search: "%#{search}%")
  # end

  def self.search(search)
    if search
        #search messages
        a = where("op_return_data_decoded ILIKE :search",
             search: "%#{search}%")

        binding.pry
        #search exchanges
        exchange_results = []
        b = Exchange.where("exchange_hash ILIKE :search", search: "%#{search}%")
        b.each do |exchange|
          exchange_results = exchange_results | exchange.messages
        end
        binding.pry
        #search blocks
        block_results = []
        c = Block.where("block_height ILIKE :search.to_i OR block_hash ILIKE :search",
             search: "%#{search}%")
        c.each do |block|
          block.exchanges.each do |exchange|
            block_results = block_results | exchange.messages
          end
        end
        binding.pry
        results = a.zip(exchange_results, block_results).flatten.compact
        binding.pry
    else
      find(:all)
    end
  end
end
