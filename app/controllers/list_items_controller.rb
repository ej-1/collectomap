class ListItemsController < ApplicationController
  before_action :set_show_for_visitor, only: [:show]
  before_action :set_list_item, only: [:edit, :update, :destroy]
  before_action :set_user_access, only: [:index]
  rescue_from ActiveRecord::RecordNotFound, :with => :redirect_to_lists
  skip_before_filter :verify_authenticity_token
  include ActionView::Helpers::TextHelper # Needed for truncate method

  # GET /list_items
  # GET /list_items.json
  def index
    # sets @list_items with set_user_access method
    #@list_items = ListItem.all
  end

  # GET /list_items/1
  # GET /list_items/1.json
  def show
    @list = List.find(@list_item.list_id)
    unless @list_item.adress == "" # Used this way of detecting if empty. nil? does not work. .first does not allow nil.
      @list_item_adress = @list_item.adress.scan(/\(([^\)]+)\)/).last.first # Get adress without coordinates.
                                                                            # http://stackoverflow.com/questions/11000724/in-ruby-get-content-in-brackets
    end
    adress = @list_item.adress.split(",")
    @marker = # Create hash of marker coordinates for list items.
      [{
         lat: adress[0],
         lng: adress[1],
         title: @list_item.title,
         desc: truncate(@list_item.description, length: 300),
         id: @list_item.id
       }]
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
    @list_item = ListItem.find(params[:id])
    @list = List.find(@list_item.list_id)
    @sublists = Sublist.all
    unless @list_item.adress == "" # Used this way of detecting if empty. nil? does not work. .first does not allow nil.
      @list_item_adress = @list_item.adress.scan(/\(([^\)]+)\)/).last.first # Get adress without coordinates.
                                                                            # http://stackoverflow.com/questions/11000724/in-ruby-get-content-in-brackets
    end
    adress = @list_item.adress.split(",")
    @marker = # Create hash of marker coordinates for list items.
      [{
         lat: adress[0],
         lng: adress[1],
         title: @list_item.title,
         desc: truncate(@list_item.description, length: 300),
         id: @list_item.id
       }]
    respond_to do |format|
      format.html
      format.json { render json: @marker }
    end
  end

  # POST /list_items
  # POST /list_items.json
  def create
    #@list_item = ListItem.new(list_item_params)
    #@list = current_list

    @list = List.find(list_item_params[:list_id])
    @list_item = @list.list_items.build(list_item_params)
    if list_item_params[:sublist_id].present?
      @sublist = Sublist.find(list_item_params[:sublist_id])
    end

    #@line_item = @lists.add_list_item(@list.id)
    #@list_item = ListItem.new

    respond_to do |format|
      if @list_item.save
        format.js # { @list_item } Goes to create.js.erb /views/list_items/create.js.erb. Don't need to declare @list_item.
        flash.now[:notice] = 'List item was successfully created.'
        #format.html { redirect_to @list_item, notice: 'List item was successfully created.' } # This is not necssary
        #format.json { render :show, status: :created, location: @list_item } # commented away since I am not building an API with JSON
      else
        format.js
        #format.html { render :new }
        format.json { render json: @list_item.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /list_items/1
  # PATCH/PUT /list_items/1.json
  def update
    respond_to do |format|
      if @list_item.update(list_item_params)
        format.js { redirect_to @list_item, notice: 'List item was successfully updated.' }
        format.html { redirect_to @list_item, notice: 'List item was successfully updated.' }
        format.json { render :show, status: :ok, location: @list_item }
      else
        format.html { render :edit }
        format.json { render json: @list_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /list_items/1
  # DELETE /list_items/1.json
  def destroy
    @list_item.destroy
    respond_to do |format|
      format.html { redirect_to list_items_url, notice: 'List item was successfully destroyed.' }
      #format.json { head :no_content } # This is not necssary
      format.js   { render :layout => false } # Added this
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_show_for_visitor
      @list_item = ListItem.find(params[:id])
    end

    def set_list_item
      list_item = ListItem.find(params[:id])
      user = who_is_user(list_item.id)
      if list_item.present? && user == current_user.id
        @list_item = ListItem.find(params[:id])
      elsif authorize_admin == true
        @list_item = ListItem.find(params[:id])
      else
        redirect_to_lists
      end
    end

    def who_is_user(list_item)
      list_item = ListItem.find(list_item)
      if list_item.list_id.nil?
        user = Sublist.find(list_item.sublist_id).user_id
      else
        user = List.find(list_item.list_id).user_id
      end
    end

    def redirect_to_lists
      redirect_to lists_path, notice: "Redirected - Sorry, you don't have acccess to that page."
    end

    def set_user_access
      user_lists = List.where(user_id: current_user)
      @list_items = ListItem.where(list_id: user_lists) # Finds all lists with all list_ids?
      if authorize_admin == true
        @list_items = ListItem.all
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_item_params
      params.require(:list_item).permit(:title, :description, :adress, :list_id, :sublist_id, :image, :remote_image_url)
    end
end
