class Exchange < ActiveRecord::Base
  belongs_to :block
  has_many :messages
  has_many :message_metadata

  validates :exchange_hash, presence: true
end
