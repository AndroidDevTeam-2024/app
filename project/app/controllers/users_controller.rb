class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_path, status: :see_other, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def register
    @user = User.new(user_params)
    @user.url = "path/to/default/avator"
    if @user.save
      render json: { 
        id: @user.id,
        avator: @user.url 
      }, status: :ok
    else
      render json: {
        errors: @user.errors.full_messages,
      }, status: :bad_request
    end
  end

  def login
    @user = User.find_by(name: params[:name])
    puts params[:name]
    puts params[:password]
    if @user
      render json: {
        id: @user.id,
        email: @user.email,
        avator: @user.url,
      }
    else 
      render json: {
        errors: @user.errors.full_messages,
      }, status: :not_found
    end
  end

  def find_by_id
    @user = User.find_by(id: params[:id])
    if @user
      render json: {
        id: @user.id,
        name: @user.name,
        email: @user.email,
        avator: @user.url,
      }, status: :ok
    else
      render json: {
        errors: "User not found",
      }, status: :not_found
    end
  end

  def update_by_id
    @user = User.find_by(id: params[:id])
    if @user
      @user.update(user_params)
      render json: {
        id: @user.id,
        name: @user.name,
        email: @user.email,
        avator: @user.url,
        password: @user.password
      }, status: :ok
    else
      render json: {
        errors: "User not found",
      }, status: :not_found
    end
  end

  def upload_avator
    @user = User.find_by(id: params[:id])
    if @user
      if params[:avator].present?
        uploaded_file = params[:avator]
        uploads_dir = Rails.root.join('public', 'uploads')
        FileUtils.mkdir_p(uploads_dir)
        file_path = uploads_dir.join(uploaded_file.original_filename)
        File.open(file_path, 'wb') do |file|
          file.write(uploaded_file.read)
        end
        relative_path = "uploads/#{uploaded_file.original_filename}"
        image_url = URI.join(request.base_url, relative_path).to_s
        if @user.update_column(:url, image_url)
          render json: {
            avator: image_url
          }, status: :ok
        else
          render json: {
            errors: "User Update Failed"
          }, status: :unprocessable_entity
        end
      else
        render json: {
          errors: "No picture uploaded",
        }, status: :bad_request
      end
    else
      render json: {
        errors: "User not found",
      }, status: :not_found
    end
  end

def get_avator
  @user = User.find_by(id: params[:id])
  if @user
    render json: {
      avator: @user.url
    }, status: :ok
  else
    render json: {
      errors: "User not found"
    }, status: :not_found
  end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      {
        name: params[:name],
        email: params[:email],
        password: params[:password],
        avator: params[:avator],
      }
    end
end
