class SublistItemsController < ApplicationController
  before_action :set_sublist_item, only: [:show, :edit, :update, :destroy]

  # GET /sublist_items
  # GET /sublist_items.json
  def index
    @sublist_items = SublistItem.all
  end

  # GET /sublist_items/1
  # GET /sublist_items/1.json
  def show
  end

  # GET /sublist_items/new
  def new
    @list = List.find(params[:id]) 
    @sublist_item = SublistItem.new
    respond_to do |format|
      format.js
    end
  end

  def render_new_sublist_form
    @sublist_item = SublistItem.new
    respond_to do |format|
      format.js # Helps to render partial.
    end
  end

  # GET /sublist_items/1/edit
  def edit
  end

  # POST /sublist_items
  # POST /sublist_items.json
  def create
    @sublist_item = SublistItem.new(sublist_item_params)

    respond_to do |format|
      if @sublist_item.save
        format.html { redirect_to @sublist_item, notice: 'Sublist item was successfully created.' }
        format.json { render :show, status: :created, location: @sublist_item }
      else
        format.html { render :new }
        format.json { render json: @sublist_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sublist_items/1
  # PATCH/PUT /sublist_items/1.json
  def update
    respond_to do |format|
      if @sublist_item.update(sublist_item_params)
        format.html { redirect_to @sublist_item, notice: 'Sublist item was successfully updated.' }
        format.json { render :show, status: :ok, location: @sublist_item }
      else
        format.html { render :edit }
        format.json { render json: @sublist_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sublist_items/1
  # DELETE /sublist_items/1.json
  def destroy
    @sublist_item.destroy
    respond_to do |format|
      format.html { redirect_to sublist_items_url, notice: 'Sublist item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sublist_item
      @sublist_item = SublistItem.find(params[:id])
      if @list.nil?
        redirect_to lists_path, notice: "Redirected - Sorry, you don't have acccess to that page."
      end
    end

    def set_list
      @list = List.where(id: params[:id], user_id: current_user).first
      if @list.nil?
        redirect_to lists_path, notice: "Redirected - Sorry, you don't have acccess to that page."
      end

    end

    def set_user_access
      @lists = List.where(user_id: current_user)
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def sublist_item_params
      params.require(:sublist_item).permit(:title, :description, :adress)
    end
end
