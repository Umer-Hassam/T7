 class MovesController < ApplicationController
  before_action :set_move, only: [:show, :edit, :update, :destroy]
  # DEVISE CHECK
  before_action :authenticate_user!, :only => [:new, :edit, :create, :destroy, :index]

  

  # GET /moves
  # GET /moves.json
  def index
    @moves = Move.all
  end

  # GET /moves/1
  # GET /moves/1.json
  def show
    @followup = Followup.new(preceding_move_id:@move.id)
    
    # ON BLOCK
    hit_mv_array = []
    @move.character.moves.each do |move|
      if move.eldest_move.startup.to_i - @move.on_block.to_i < 10 and move.jails_on_hit?
        hit_mv_array << move
      elsif move.parent == nil
        if move.eldest_move.startup.to_i - @move.on_block.to_i < 10
          hit_mv_array << move
        end
      end
    end
    @on_block_moves = hit_mv_array
    
    # ON HIT
    hit_mv_array = []
    @move.character.moves.each do |move|
      if move.eldest_move.startup.to_i - @move.on_hit.to_i < 10 and move.jails_on_hit?
        hit_mv_array << move
      elsif move.parent == nil
        if move.eldest_move.startup.to_i - @move.on_hit.to_i < 10
          hit_mv_array << move
        end
      end
    end
    @on_hit_moves = hit_mv_array
    
    # ON COUNTER HIT
    hit_mv_array = []
    @move.character.moves.each do |move|
      if move.eldest_move.startup.to_i - @move.on_counter_hit.to_i < 10 and move.jails_on_hit?
        hit_mv_array << move
      elsif move.parent == nil
        if move.eldest_move.startup.to_i - @move.on_counter_hit.to_i < 10
          hit_mv_array << move
        end
      end
    end
    @on_counter_hit_moves = hit_mv_array

  end

  # GET /moves/new
  def new
    if params[:copy_from] != nil
      cf = Move.find(params[:copy_from])
      @move = Move.new(:name => cf.name, 
                       :input =>  cf.input,
                       :hit_level => cf.hit_level,
                       :hit_damage => cf.hit_damage,
                       :conter_hit_damage => cf.conter_hit_damage,
                       :startup => cf.startup,
                       :on_block => cf.on_block,
                       :on_hit => cf.on_hit,
                       :on_counter_hit => cf.on_counter_hit)
    else
      @move = Move.new
    end
      

    if params["parent_move_id"].blank?
      @stance_id = params[:stance_id]
    else
      @stance_id = Move.find(params["parent_move_id"]).stance_id
    end
    
  end

  # GET /moves/1/edit
  def edit
    @stance_id = @move.stance_id
    @stance_id = params[:stance_id]
  end

  # POST /moves
  # POST /moves.json
  def create
    @move = Move.new(move_params)

    respond_to do |format|
      if @move.save
        
        if params[:create_and_add_new]
          format.html { 
            redirect_to controller: 'moves', action: 'new', char_id: @move.character.id, notice: 'Move was successfully created.'
           }
        elsif params[:create_and_add_extension]
          format.html { 
            redirect_to controller: 'moves', action: 'new', char_id: @move.character.id, parent_move_id:@move.id, notice: 'Move was successfully created.'
          }
        else
          format.html { redirect_to @move.character, notice: 'Character was successfully created.' }
        end
        
        #format.html { redirect_to @move.character }#redirect_to @move, notice: 'Move was successfully created.' }
        format.json { render :show, status: :created, location: @move }
      else
        format.html { render :new }
        format.json { render json: @move.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /moves/1
  # PATCH/PUT /moves/1.json
  def update
    
    respond_to do |format|
      if @move.update(move_params)
        if params[:update_and_add_new]
          format.html { 
            redirect_to controller: 'moves', action: 'new', char_id: @move.character.id, notice: 'Move was successfully created.'
           }
        elsif params[:update_and_add_extension]
          format.html { 
            redirect_to controller: 'moves', action: 'new', char_id: @move.character.id, parent_move_id:@move.id, notice: 'Move was successfully created.'
          }
        else
          format.html { redirect_to @move.character, notice: 'Character was successfully created.' }
        end
        
        #format.html { redirect_to @move.character }#redirect_to @move, notice: 'Move was successfully updated.' }
        format.json { render :show, status: :ok, location: @move }
      else
        format.html { render :edit }
        format.json { render json: @move.errors, status: :unprocessable_entity }
      end
    end
  end
 
  # DELETE /moves/1
  # DELETE /moves/1.json
  def destroy
    @move.destroy
    respond_to do |format|
      format.html { redirect_to @move.character, notice: 'Move was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_move
      @move = Move.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def move_params
      params.require(:move).permit(:name, :input, :startup, :on_block, :on_hit, :on_counter_hit, :hit_damage, :conter_hit_damage, :hit_level, :counter, :character_id, :cancel_input, :stance_transition_input, :type, :stance_id, :parent_id, :property_ids => [], :stance_transition_ids => [], :effects_hit_ids => [], :effects_counter_hit_ids => [], :effects_block_ids => [], :purpose_ids => [])
    end
end
