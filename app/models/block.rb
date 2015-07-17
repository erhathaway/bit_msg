class Block < ActiveRecord::Base
  has_many :exchanges
  has_many :messages, through: :exchanges

  validates :block_height, presence: true
  validates :block_hash, presence: true
  # validates :parsed_date, presence: true

  def add_block_header(block_header)
    update(block_height: block_header["data"]["nb"])
    update(block_hash: block_header["data"]["hash"])
    # update(date_posted: block_header["data"]["time_utc"])
  end
end
