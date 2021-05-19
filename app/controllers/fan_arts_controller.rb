class FanArtsController < ApplicationController
  before_action :set_fan_art, only: [:show, :edit, :update, :destroy]
  # DEVISE CHECK
  before_action :authenticate_user!, :only => [:new, :edit, :create, :destroy]
  
  # GET /fan_arts
  # GET /fan_arts.json
  def index
    @fan_arts = FanArt.all
  end

  # GET /fan_arts/1
  # GET /fan_arts/1.json
  def show
  end

  # GET /fan_arts/new
  def new
    @fan_art = FanArt.new
  end

  # GET /fan_arts/1/edit
  def edit
  end

  # POST /fan_arts
  # POST /fan_arts.json
  def create
    @fan_art = FanArt.new(fan_art_params)

    respond_to do |format|
      if @fan_art.save
        format.html { redirect_to @fan_art, notice: 'Fan art was successfully created.' }
        format.json { render :show, status: :created, location: @fan_art }
      else
        format.html { render :new }
        format.json { render json: @fan_art.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fan_arts/1
  # PATCH/PUT /fan_arts/1.json
  def update
    respond_to do |format|
      if @fan_art.update(fan_art_params)
        format.html { redirect_to @fan_art, notice: 'Fan art was successfully updated.' }
        format.json { render :show, status: :ok, location: @fan_art }
      else
        format.html { render :edit }
        format.json { render json: @fan_art.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fan_arts/1
  # DELETE /fan_arts/1.json
  def destroy
    @fan_art.destroy
    respond_to do |format|
      format.html { redirect_to fan_arts_url, notice: 'Fan art was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fan_art
      @fan_art = FanArt.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fan_art_params
      params.require(:fan_art).permit(:link, :artist_name, :artist_link, :art_type, :style, :is_main, :description, :character_id, :profile_id)
    end
end
