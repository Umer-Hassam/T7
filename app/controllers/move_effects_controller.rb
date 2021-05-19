class MoveEffectsController < ApplicationController
  before_action :set_move_effect, only: [:show, :edit, :update, :destroy]

  # DEVISE CHECK
  before_action :authenticate_user!, :only => [:new, :edit, :create, :destroy, :show, :index]

  # GET /move_effects
  # GET /move_effects.json
  def index
    @move_effects = MoveEffect.all
  end

  # GET /move_effects/1
  # GET /move_effects/1.json
  def show
  end

  # GET /move_effects/new
  def new
    @move_effect = MoveEffect.new
  end

  # GET /move_effects/1/edit
  def edit
  end

  # POST /move_effects
  # POST /move_effects.json
  def create
    @move_effect = MoveEffect.new(move_effect_params)

    respond_to do |format|
      if @move_effect.save
        format.html { redirect_to @move_effect, notice: 'Move effect was successfully created.' }
        format.json { render :show, status: :created, location: @move_effect }
      else
        format.html { render :new }
        format.json { render json: @move_effect.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /move_effects/1
  # PATCH/PUT /move_effects/1.json
  def update
    respond_to do |format|
      if @move_effect.update(move_effect_params)
        format.html { redirect_to @move_effect, notice: 'Move effect was successfully updated.' }
        format.json { render :show, status: :ok, location: @move_effect }
      else
        format.html { render :edit }
        format.json { render json: @move_effect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /move_effects/1
  # DELETE /move_effects/1.json
  def destroy
    @move_effect.destroy
    respond_to do |format|
      format.html { redirect_to move_effects_url, notice: 'Move effect was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_move_effect
      @move_effect = MoveEffect.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def move_effect_params
      params.require(:move_effect).permit(:name, :image_url, :desc)
    end
end
