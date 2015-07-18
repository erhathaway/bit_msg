class MessageTag < ActiveRecord::Base
  has_many :messages
  has_many :message_metadata

  validates :tag, presence: true
end
