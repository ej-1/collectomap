class SublistsController < ApplicationController
  before_action :set_sublist, only: [:show, :edit, :update, :destroy]

  # GET /sublists
  # GET /sublists.json
  def index
    @sublists = Sublist.all
  end

  # GET /sublists/1
  # GET /sublists/1.json
  def show
  end

  # GET /sublists/new
  def new
    @sublist = Sublist.new
  end

  # GET /sublists/1/edit
  def edit
  end

  # POST /sublists
  # POST /sublists.json
  def create
    @sublist = Sublist.new(sublist_params)

    respond_to do |format|
      if @sublist.save
        format.html { redirect_to @sublist, notice: 'Sublist was successfully created.' }
        format.json { render :show, status: :created, location: @sublist }
      else
        format.html { render :new }
        format.json { render json: @sublist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sublists/1
  # PATCH/PUT /sublists/1.json
  def update
    respond_to do |format|
      if @sublist.update(sublist_params)
        format.html { redirect_to @sublist, notice: 'Sublist was successfully updated.' }
        format.json { render :show, status: :ok, location: @sublist }
      else
        format.html { render :edit }
        format.json { render json: @sublist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sublists/1
  # DELETE /sublists/1.json
  def destroy
    @sublist.destroy
    respond_to do |format|
      format.html { redirect_to sublists_url, notice: 'Sublist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sublist
      @sublist = Sublist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sublist_params
      params.require(:sublist).permit(:title, :description, :adress)
    end
end
