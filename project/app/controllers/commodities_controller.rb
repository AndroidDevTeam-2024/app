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

  def find_by_category
    category = params[:category]
    @commodities = Commodity.where(category: category)
    if @commodities
      render json: {
        # 返回每一个商品的id, name, price, introduction, homepage组成的数组
        commodities: @commodities.map { |commodity| {
          id: commodity.id,
          name: commodity.name,
          price: commodity.price,
          introduction: commodity.introduction,
          homepage: commodity.homepage,
        } }
      }
    else
      render json: {
        errors: "No commodity found"
      }, status: :not_found
    end
  end

  def find_by_publisher
    user = User.find_by(id: params[:publisher])
    if user 
      @commodities = Commodity.where(business_id: user.id)
      if @commodities
        render json: {
          # 返回每一个商品的id, name, price, introduction, homepage组成的数组
          commodities: @commodities.map { |commodity| {
            id: commodity.id,
            name: commodity.name,
            price: commodity.price,
            introduction: commodity.introduction,
            homepage: commodity.homepage,
          } }
        }
      else
        render json: {
          errors: "No commodity found"
        }, status: :not_found
      end
    else
      render json: {
        errors: "User not found"
      }, status: :not_found
    end
  end

  def find_all
    @commodities = Commodity.all
    if @commodities
      render json: {
        # 返回每一个商品的id, name, price, introduction, homepage组成的数组
        commodities: @commodities.map { |commodity| {
          id: commodity.id,
          name: commodity.name,
          price: commodity.price,
          introduction: commodity.introduction,
          homepage: commodity.homepage,
        } }
      }
    else
      render json: {
        errors: "No commodity found"
      }, status: :not_found
    end
  end

  def find_by_id
    @commodity = Commodity.find_by(id: params[:id])
    if @commodity
      render json: {
        id: @commodity.id,
        name: @commodity.name,
        price: @commodity.price,
        introduction: @commodity.introduction,
        business_id: @commodity.business_id,
        homepage: @commodity.homepage,
        exist: @commodity.exist,
      }
    else
      render json: {
        errors: "Commodity not found"
      }, status: :not_found
    end
  end

  def delete_by_id
    @commodity = Commodity.find_by(id: params[:id])
    if @commodity
      @commodity.destroy!
      render json: {
        message: "Commodity deleted"
      }, status: :ok
    else
      render json: {
        errors: "Commodity not found"
      }, status: :not_found
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
