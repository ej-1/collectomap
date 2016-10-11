class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_filter :authorize_user, only: [:new, :create]
  before_action :set_user_access, only: [:index]
  rescue_from ActiveRecord::RecordNotFound, :with => :redirect_to_users

  # GET /users
  # GET /users.json
  def index
    #@users = User.order(:name)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to lists_url, notice: "User #{@user.name} was successfully created." }
        #format.html { redirect_to users_url, notice: "User #{@user.name} was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User #{@user.name} was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if authorize_admin == true
        @user = User.find(params[:id])
      elsif User.find(params[:id]).id == current_user.id
        @user = User.where(id: current_user).first
      else
        redirect_to users_path, notice: "Redirected - Sorry, you don't have acccess to that page."
      end
    end

    def set_user_access
      @users = User.where(id: current_user.id)
      if authorize_admin == true
        @users = User.all
      end
    end

    def redirect_to_users
      redirect_to users_path, notice: "Redirected - Sorry, you don't have acccess to that page."
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :avatar, :remote_avatar_url)
    end
end
