class MessagesController < ApplicationController

# require "#{Rails.root}/lib/bitcoin/parse"
# require "#{Rails.root}/lib/bitcoin/parse"


  def index
    if params[:search].present?
      @messages = Message.search(params[:search]).page params[:page]
    else
      @messages = Message.joins("
                    JOIN exchanges ON
                      Exchanges.id = Messages.exchange_id
                    JOIN blocks ON
                      Blocks.id = Exchanges.block_id").order('date_posted').page params[:page]
      # @messages = Message.all.page params[:page]
    end
  end

  def show
    @message = Message.find(params[:id])
  end

end
