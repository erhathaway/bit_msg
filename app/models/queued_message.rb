class QueuedMessage < ActiveRecord::Base
  validates :message, presence: true
  validates :tx_state, presence: true
end
