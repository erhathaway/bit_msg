class Message < ActiveRecord::Base
  belongs_to :block
  belongs_to :message_tag
  has_many :message_metadata

  validates :tx_hash, presence: true
  validates :op_return_data, presence: true
  validates :block_id, presence: true
end
