class Transaction < ActiveRecord::Base
  belongs_to :block
  has_many :messages
  has_many :message_metadata

  validates :tx_hash, presence: true
end
