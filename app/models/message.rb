class Message < ActiveRecord::Base
  belongs_to :exchange
  belongs_to :block
  belongs_to :message_tag
  has_many :message_metadata

  validates :op_return_data_raw, presence: true
  validates :op_return_data_decoded, presence: true

end
