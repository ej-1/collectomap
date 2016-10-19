class ListsController < ApplicationController
  before_action :set_show_for_visitor, only: [:show]
  before_action :set_list, only: [:edit, :update, :destroy]
  before_action :set_user_access, only: [:index]
  include ActionView::Helpers::TextHelper # Needed for truncate method

  # GET /lists
  def index
  end

  # GET /lists/1
  def show
    if @list.nil?
      @sublists = List.new
    else
      @sublists = @list.sublists.order('title ASC')
      @sublists_for_partial = @list.sublists.order('title ASC')
      # @sublists_for_partial = List.where(parent_id: params[:id]).order('title ASC') # Created this as a workaround. 
      # After creating custom helper method for dropdown in list item form, then the @sublists vairable got overwritten.
    end
    @list_items = ListItem.all
    @markers = ListItem.set_marker(@list_items)
    respond_to do |format|
      format.html
      format.json { render json: @markers }
    end
  end

  # GET /lists/newz
  def new
    if params[:list_parent].present?
      @list_parent = params[:list_parent]
      @list = List.new(parent_id: params[:list_parent])
      respond_to do |format|
        format.js
      end
    else
      @list = List.new
    end
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  def create
    @list = List.new(list_params)
    @list_item = ListItem.new
    @sublists = List.where(parent_id: list_params["parent_id"]).order('title ASC')
      @parent_id = list_params["parent_id"]
    respond_to do |format|
      if @list.save && @parent_id.present?
        format.js
      elsif @list.save
        format.html { redirect_to @list, notice: 'List was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /lists/1
  def update
    respond_to do |format|
      if @list.update(list_params)
        if @list.parent_id.nil?
          format.html { redirect_to @list, notice: 'List was successfully updated.' }
        else
          format.html { redirect_to List.find(@list.parent_id), notice: 'List was successfully updated.' }
        end
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /lists/1
  def destroy
    @list.destroy
    respond_to do |format|
      if @list.parent_id.nil?
        format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
      else
        @sublists = List.where(parent_id: @list.parent_id).order('title ASC')
        @list = List.find(@list.parent_id) # Needed for re-rendering list items form with updated sublists as options. Selected default option.
        @list_item = ListItem.new # Needed for re-rendering list items form with updated sublists as options.
        format.js
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_show_for_visitor
      @list = List.find(params[:id])
      @list_items = @list.list_items.order("created_at DESC")
      @created_by_user = @list.user
    end

    def set_list
      @list = List.find(params[:id])
      @user = @list.user
      if @user == current_user or authorize_admin == true
      else
        redirect_to lists_path, notice: "Redirected - Sorry, you don't have acccess to that page."
      end
    end

    def set_user_access
      if authorize_admin # Admin sees all lists.
        @lists = List.only_lists
      elsif current_user # If user is logged in, users sees his/her lists.
        @lists = current_user.lists
      elsif params[:gallery_of_user].present? # If a not logged in visitor visits a users profile.
        @created_by_user = User.find(params[:gallery_of_user])
        @lists = List.where(user_id: params[:gallery_of_user]).only_lists
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:title, :description, :parent_id, :user_id, :list_image, :remote_list_image_url)
    end
end
