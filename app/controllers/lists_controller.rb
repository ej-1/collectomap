class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :set_user_access, only: [:index]

  # GET /lists
  # GET /lists.json
  def index
    # sets @lists with set_user_access method
    #@list_item = ListItem.new
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
    @list_items = ListItem.where(list_id: params[:id], sublist_id: nil).order("created_at DESC")
    if Sublist.where(list_id: params[:id]).order('title ASC').nil?
      @sublists = Sublist.new
    else
      @sublists = Sublist.where(list_id: params[:id]).order('title ASC')
    end
  end

  # GET /lists/newz
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = List.new(list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
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
    def list_params
      params.require(:list).permit(:title, :description, :user_id)
    end
end
