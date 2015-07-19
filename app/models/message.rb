class Message < ActiveRecord::Base
  belongs_to :exchange
  belongs_to :block
  belongs_to :message_tag
  has_many :message_metadata

  validates :op_return_data_raw, presence: true
  validates :op_return_data_decoded, presence: true

  paginates_per 50

  def self.search(search)
    if search
        joins(
          "LEFT OUTER JOIN message_tags ON
          message_tags.id = Messages.message_tag_id
          JOIN exchanges ON
            exchanges.id = Messages.exchange_id
          JOIN blocks ON
            Blocks.id = Exchanges.block_id"
              ).where("
                op_return_data_decoded ILIKE :search OR
                exchange_hash ILIKE :search OR
                block_hash ILIKE :search OR
                block_height ILIKE :search", search: "%#{search}%")
          # binding.pry
    else
      find(:all)
    end
  end
end
