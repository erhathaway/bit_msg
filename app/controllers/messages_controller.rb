class MessagesController < ApplicationController

# require "#{Rails.root}/lib/bitcoin/parse"
# require "#{Rails.root}/lib/bitcoin/parse"


  def index
    if params[:search].present?
      @messages = Message.search(params[:search]).order('date_posted DESC').page params[:page]
    else
      @messages = Message.joins("
                    JOIN exchanges ON
                      Exchanges.id = Messages.exchange_id
                    JOIN blocks ON
                      Blocks.id = Exchanges.block_id").order('date_posted DESC').page params[:page]
      # @messages = Message.all.page params[:page]
    end
  end

  def show
    @message = Message.find(params[:id])
  end

  def get_data
    @message = Message.find(params[:message_id])
    render json: { status: :ok,
                   raw: @message.op_return_data_raw,
                   decoded: @message.op_return_data_decoded,
                   tx_hash: @message.exchange.exchange_hash,
                   block_hash: @message.exchange.block.block_hash,
                   block_height: @message.exchange.block.block_height,
                   date_posted: @message.exchange.block.date_posted }
  end

  protected

  def message_params
    params.require(:message).permit(:id)
  end

end
