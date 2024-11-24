class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  # GET /messages or /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1 or /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  def send_message
    sender = User.find_by(id: message_params[:publisher])
    receiver = User.find_by(id: message_params[:acceptor])
    if sender && receiver
      @message = Message.new(message_params)
      if @message.save
        render json: {
          id: @message.id,
        }, status: :ok
      else
        render json: {
          errors: "Message not sent"
        }, status: :bad_request
      end
    else
      render json: {
        message: "Sender or receiver not found"
      }, status: :not_found
    end
  end

  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: "Message was successfully created." }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy!

    respond_to do |format|
      format.html { redirect_to messages_path, status: :see_other, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def find_by_id
    @message = Message.find_by(id: params[:id])
    if @message
      render json: {
        id: @message.id,
        date: @message.date,
        content: @message.content,
        publisher: @message.publisher,
        acceptor: @message.acceptor
      }, status: :ok
    else
      render json: {
        message: "Message not found"
      }, status: :not_found
    end
  end

  def find_by_receiver
    receiver_id = params[:receiver].to_i

    # 获取每个发送方的最新消息的 ID
    latest_message_ids = Message.where(acceptor: receiver_id)
                                .group(:publisher)
                                .maximum(:id)
                                .values

    # 查询这些最新消息
    latest_messages = Message.where(id: latest_message_ids)
    if latest_messages.any?
      render json: {
        messages: latest_messages.map { |message| {
          id: message.id,
          date: message.date,
          content: message.content,
          publisher: message.publisher,
          publisher_name: User.find_by(id: message.publisher).name,
          acceptor: message.acceptor
        } }
      }
    else
      render json: {
        message: "Message not found"
      }, status: :not_found
    end
  end

  def delete_by_id
    @message = Message.find_by(id: params[:id])
    if @message
      @message.destroy!
      render json: {
        message: "Message deleted"
      }, status: :ok
    else
      render json: {
        messages: "Message not found"
      }, status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:date, :content, :publisher, :acceptor)
    end
end
