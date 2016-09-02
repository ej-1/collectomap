class ListItemsController < ApplicationController
  before_action :set_list_item, only: [:show, :edit, :update, :destroy]
  before_action :set_user_access, only: [:index]
  rescue_from ActiveRecord::RecordNotFound, :with => :redirect_to_lists

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

    def set_list_item
      list_item = ListItem.find(params[:id])
      user = who_is_user(list_item.id)
      if list_item.present? && user == current_user.id
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
      params.require(:list_item).permit(:title, :description, :adress, :list_id, :sublist_id)
    end
end
