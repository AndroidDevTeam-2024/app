class DealsController < ApplicationController
  before_action :set_deal, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  # GET /deals or /deals.json
  def index
    @deals = Deal.all
  end

  # GET /deals/1 or /deals/1.json
  def show
  end

  # GET /deals/new
  def new
    @deal = Deal.new
  end

  # GET /deals/1/edit
  def edit
  end

  # POST /deals or /deals.json
  def create
    @deal = Deal.new(deal_params)

    respond_to do |format|
      if @deal.save
        format.html { redirect_to @deal, notice: "Deal was successfully created." }
        format.json { render :show, status: :created, location: @deal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deals/1 or /deals/1.json
  def update
    respond_to do |format|
      if @deal.update(deal_params)
        format.html { redirect_to @deal, notice: "Deal was successfully updated." }
        format.json { render :show, status: :ok, location: @deal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deals/1 or /deals/1.json
  def destroy
    @deal.destroy!

    respond_to do |format|
      format.html { redirect_to deals_path, status: :see_other, notice: "Deal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def comment
    @deal = Deal.find(params[:deal_id])
    if @deal
      @deal.comment = params[:comment]
      commodity = Commodity.find_by(id: @deal.commodity)
      if @deal.save
        render json: { 
          homepage: commodity.homepage
        }, status: :ok
      else
        render json: { 
          errors: @deal.errors.full_messages
        }, status: :bad_request
      end
    else
      render json: { 
        status: "Deal not found"
      }, status: :not_found
    end
  end

  def post
    seller = User.find_by(id: params[:seller])
    customer = User.find_by(id: params[:customer])
    commodity = Commodity.find_by(id: params[:commodity])
    if seller && customer && commodity && commodity.exist
      @deal = Deal.new(deal_params)
      commodity.exist = false
      if @deal.save
        render json: { 
          id: @deal.id 
        }, status: :ok
      else
        render json: { 
          errors: "Deal save error" 
        }, status: :bad_request
      end
    else
      render json: { 
        status: "Seller or Customer or Commodity not found" 
      }, status: :not_found
    end
  end

  def find_by_id
    @deal = Deal.find_by(id: params[:id])
    if @deal
      render json: { 
        id: @deal.id,
        seller: @deal.seller,
        customer: @deal.customer,
        commodity: @deal.commodity,
        date: @deal.date,
        comment: @deal.comment
      }, status: :ok
    else
      render json: { 
        errors: "Deal not found" 
      }, status: :not_found
    end
  end

  def find_by_person
    deals = Deal.where(seller: params[:id]).or(Deal.where(customer: params[:id]))
    if deals
      render json: { 
        deals: deals.map { |deal| {
          id: deal.id,
          seller: deal.seller,
          customer: deal.customer,
          commodity: deal.commodity,
          date: deal.date,
          comment: deal.comment
        } }
      }, status: :ok
    else
      render json: { 
        errors: "Deal not found" 
      }, status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deal
      @deal = Deal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def deal_params
      params.require(:deal).permit(:seller, :customer, :commodity, :date, :comment)
    end
end
