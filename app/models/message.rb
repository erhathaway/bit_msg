class Message < ActiveRecord::Base
  belongs_to :exchange
  belongs_to :block
  belongs_to :message_tag
  has_many :message_metadata

  validates :op_return_data_raw, presence: true
  validates :op_return_data_decoded, presence: true

  paginates_per 100

  def self.search(search)
    if search
        #search messages
        a = where("op_return_data_decoded ILIKE :search",
             search: "%#{search}%")

        #search message tags
        tag_results = []
        b = MessageTag.where("tag ILIKE :search", search: "%#{search}%")
        b.each do |tag|
          tag_results = tag_results | tag.messages
        end

        #interleave two different results
        a.zip(tag_results).flatten.compact
    else
      find(:all)
    end
  end
end
