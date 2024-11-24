class CommoditiesController < ApplicationController
  before_action :set_commodity, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  # GET /commodities or /commodities.json
  def index
    @commodities = Commodity.all
  end

  # GET /commodities/1 or /commodities/1.json
  def show
  end

  # GET /commodities/new
  def new
    @commodity = Commodity.new
  end

  # GET /commodities/1/edit
  def edit
  end

  # POST /commodities or /commodities.json
  def create
    @commodity = Commodity.new(commodity_params)

    respond_to do |format|
      if @commodity.save
        format.html { redirect_to @commodity, notice: "Commodity was successfully created." }
        format.json { render :show, status: :created, location: @commodity }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @commodity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commodities/1 or /commodities/1.json
  def update
    respond_to do |format|
      if @commodity.update(commodity_params)
        format.html { redirect_to @commodity, notice: "Commodity was successfully updated." }
        format.json { render :show, status: :ok, location: @commodity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @commodity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commodities/1 or /commodities/1.json
  def destroy
    @commodity.destroy!

    respond_to do |format|
      format.html { redirect_to commodities_path, status: :see_other, notice: "Commodity was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def register
    business_id = params[:business_id]
    @user = User.find_by(id: business_id)
    if @user
      @commodity = Commodity.new(commodity_params)
      @commodity.homepage = "path/to/default/homepage"
      @commodity.business_id = business_id
      if @commodity.save
        render json: {
          id: @commodity.id,
          homepage: @commodity.homepage,
        }, status: :ok
      else
        render json: {
          errors: @commodity.errors.full_messages
        }, status: :bad_request
      end
    else
      render json: {
        errors: "Business User not found"
      }, status: :bad_request
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commodity
      @commodity = Commodity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def commodity_params
      params.require(:commodity).permit(:name, :price, :introduction, :business_id)
    end
end
