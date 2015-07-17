class Block < ActiveRecord::Base
  has_many :messages

  validates :block_height, presence: true
  validates :block_hash, presence: true
  # validates :parsed_date, presence: true
end
