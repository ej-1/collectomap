class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_filter :authorize_user, only: [:new, :create]
  before_action :set_user_access, only: [:index]
  rescue_from ActiveRecord::RecordNotFound, :with => :redirect_to_users

  # GET /users
  def index
  end

  # GET /users/1
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
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to lists_url, notice: "User #{@user.name} was successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User #{@user.name} was successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      if authorize_admin
      elsif @user.id == current_user.id
        @user = current_user
      else
        redirect_to_lists
      end
    end

    def set_user_access
      if authorize_admin
        @users = User.all
      else
        redirect_to_lists
      end
    end

    def redirect_to_lists
      redirect_to lists_path, notice: "Redirected - Sorry, you don't have acccess to that page."
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :avatar, :remote_avatar_url)
    end
end
