class ListItemsController < ApplicationController
  before_action :show_for_visitor, only: [:show]
  before_action :set_list_item, only: [:edit, :update, :destroy]
  before_action :set_user_access, only: [:index]
  #rescue_from ActiveRecord::RecordNotFound, :with => :redirect_to_lists
  skip_before_filter :verify_authenticity_token
  include ActionView::Helpers::TextHelper # Needed for truncate method

  # GET /list_items
  def index
  end

  # GET /list_items/1
  def show
    @marker = ListItem.set_marker(@list_item)
    respond_to do |format|
      format.html
      format.json { render json: @marker }
    end
  end

  # GET /list_items/new
  def new
    @list_item = ListItem.new
  end

  # GET /list_items/1/edit
  def edit
    if @list.parent_id == nil
      @sublists = @list.sublists
    else
      @sublists = List.find(@list.parent_id).sublists
    end
    ListItem.set_marker(@list_items)
    respond_to do |format|
      format.html
      format.json { render json: @marker }
    end
  end

  # POST /list_items
  def create
    @list = List.find(list_item_params["list_id"])
    if @list.parent_id.present?
      @sublist = List.find(list_item_params["list_id"])
    end
    @list_item = @list.list_items.build(list_item_params)
    respond_to do |format|
      if @list_item.save
        format.js # { @list_item } Goes to create.js.erb /views/list_items/create.js.erb. Don't need to declare @list_item.
        flash.now[:notice] = 'List item was successfully created.'
      else
        format.js
      end
    end
  end


  # PATCH/PUT /list_items/1
  def update
    respond_to do |format|
      if @list_item.update(list_item_params)
        format.html { redirect_to @list_item, notice: 'List item was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /list_items/1
  def destroy
    @list_item.destroy
    respond_to do |format|
      format.html { redirect_to list_items_url, notice: 'List item was successfully destroyed.' }
      format.js   { render :layout => false } # Added this
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def show_for_visitor
      @list_item = ListItem.find(params[:id])
      @list = List.find(@list_item.list_id)
      @created_by_user = @list.user
    end

    def set_list_item
      @list_item = ListItem.find(params[:id])
      @list = List.find(@list_item.list_id)
      @user = @list.user
      if @user == current_user 
      elsif authorize_admin == true
        @list_items = ListItem.all
      else
        redirect_to_lists
      end
    end

    def set_user_access
      if authorize_admin == true
        @list_items = ListItem.all
      else
        redirect_to landing_path
      end
    end

    def redirect_to_lists
      redirect_to lists_path, notice: "Redirected - Sorry, you don't have acccess to that page."
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_item_params
      params.require(:list_item).permit(:title, :description, :adress, :list_id, :image, :remote_image_url)
    end
end
