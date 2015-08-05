class QueuedMessage < ActiveRecord::Base
  belongs_to :bit_coupon

  validates :message, presence: true
  validates :tx_state, presence: true
end
