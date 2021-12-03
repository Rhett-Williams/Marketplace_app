class RequestsController < ApplicationController
  before_action :set_request, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy ]
  # GET /requests or /requests.json
  def index
    @requests = Request.all
  end

  # GET /requests/1 or /requests/1.json
  def show
    
    Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: [{
        name: @request.display_name,
        description: @request.reason,
        images: [url_for(@request.image)],
        amount: @request.dollar_amount,
        currency: 'aud',
        quantity: 1,
      }],
      payment_intent_data: {
        metadata: {
          request_id: @request.id,
          user_id: current_user.id
        }
      },
        success_url: "#{root_url}payment/success/#{@request.id}",
        cancel_url: "#{root_url}payment/cancel/#{@request.id}"
    )
    @session_id = session.id
  end

  # GET /requests/new
  def new
    # @request = Request.new
    @request = current_user.requests.build
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests or /requests.json
  def create
    # @request = Request.new(request_params)
    @request = current_user.requests.build(request_params)

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: "Request was successfully created." }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /requests/1 or /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: "Request was successfully updated." }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1 or /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: "Request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @request = current_user.requests.find_by(id: params[:id])
    redirect_to requests_path, notice: "Not authorised to edit this request" if @request.nil?
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_params
      params.require(:request).permit(:display_name, :reason, :dollar_amount, :user_id, :image)
    end
end
