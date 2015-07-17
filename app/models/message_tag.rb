class MessageMetadata < ActiveRecord::Base
  belongs_to :messages
  belongs_to :message_tag
  belongs_to :user

  validates :user_id, presence: true
end
