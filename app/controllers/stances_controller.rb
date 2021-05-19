class StancesController < ApplicationController
  before_action :set_stance, only: [:show, :edit, :update, :destroy]
  # DEVISE CHECK
  before_action :authenticate_user!, :only => [:new, :edit, :create, :destroy, :show, :index]
  

  # GET /stances
  # GET /stances.json
  def index
    @stances = Stance.all
  end

  # GET /stances/1
  # GET /stances/1.json
  def show
  end

  # GET /stances/new
  def new
    @stance = Stance.new
  end

  # GET /stances/1/edit
  def edit
    @stance = Stance.find(params[:id])
  end

  # POST /stances
  # POST /stances.json
  def create
    @stance = Stance.new(stance_params)

    respond_to do |format|
      if @stance.save
        format.html { redirect_to @stance, notice: 'Stance was successfully created.' }
        format.json { render :show, status: :created, location: @stance }
      else
        format.html { render :new }
        format.json { render json: @stance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stances/1
  # PATCH/PUT /stances/1.json
  def update
    respond_to do |format|
      if @stance.update(stance_params)
        format.html { redirect_to @stance, notice: 'Stance was successfully updated.' }
        format.json { render :show, status: :ok, location: @stance }
      else
        format.html { render :edit }
        format.json { render json: @stance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stances/1
  # DELETE /stances/1.json
  def destroy
    @stance.destroy
    respond_to do |format|
      format.html { redirect_to stances_url, notice: 'Stance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_all_moves
    @stance = Stance.find(params[:id])

    if @stance.moves.destroy_all
      flash[:notice] = "All Moves in Stance \"#{@stance.name}\" were destroyed."
      
    else
      flash[:notice] = "Unable to destroy moves in Stance \"#{@stance.name}\": #{@stance.errors}."
    end
    
    redirect_to @stance.character
    
  end

  def backup_all_moves
    @stance = Stance.find(params[:id])
    render json: @stance.backup_moves
  end

  def save_move_from_dict(move_dict, parent_move)

    @move = @stance.moves.where(:input => move_dict["input"]).select{ |m| move_dict["parent"].blank? ? m.parent == nil : (m.parent == nil ? false : m.parent.input == move_dict["parent"])}.first
      
      if @move == nil
        @move = @stance.moves.create()
      end

      @move.name = move_dict["name"].blank? ? @move.name : move_dict["name"]

      @move.input     = move_dict["input"] 
      @move.hit_level = move_dict["hit_level"].blank? ? @move.hit_level : move_dict["hit_level"]

      
      @move.cancel_input = move_dict["cancel_input"].blank? ? @move.cancel_input : move_dict["cancel_input"]

      
      @move.startup = move_dict["startup"].blank? ? @move.startup : move_dict["startup"]
      @move.on_block = move_dict["on_block"].blank? ? @move.on_block : move_dict["on_block"]
      @move.on_hit = move_dict["on_hit"].blank? ? @move.on_hit : move_dict["on_hit"]
      @move.on_counter_hit = move_dict["on_counter_hit"].blank? ? @move.on_counter_hit : move_dict["on_counter_hit"]

      
      @move.hit_damage = move_dict["hit_damage"].blank? ? @move.hit_damage : move_dict["hit_damage"]
      @move.conter_hit_damage = move_dict["conter_hit_damage"].blank? ? @move.conter_hit_damage : move_dict["conter_hit_damage"]
      
       
      @move.counter = move_dict["counter"].blank? ? @move.counter : move_dict["counter"]

      # ADDING RELATIONSHIPS

      @move.character = @stance.character
      
      #:move_purpose => MovePurpose.where('lower(name) = ?', bb["move_purpose"][0].downcase).first,
      if !move_dict["move_purpose"].blank?
        move_dict["move_purpose"].each do |purpose|
          purp = Purpose.where('lower(name) = ?', purpose.downcase).first
          if !purp.blank?
            @move.purposes << purp
          end
        end
      end

      #:properties =>   properties.map { |p| p.name },
      if !move_dict["properties"].blank?
        move_dict["properties"].each do |property|
          prop = Property.where('lower(name) = ?', property.downcase).first
          if !prop.blank?
            @move.properties << prop
          end
        end
      end

      #:effects_hit =>         effects_hit.map { |p| p.name },
      if !move_dict["effects_hit"].blank?
        move_dict["effects_hit"].each do |item|
          val = MoveEffect.where('lower(name) = ?', item.downcase).first
          if !val.blank?
            @move.effects_hit << val
          end
        end
      end
      #:effects_counter_hit => effects_counter_hit.map { |p| p.name },
      if !move_dict["effects_counter_hit"].blank?
        move_dict["effects_counter_hit"].each do |item|
          val = MoveEffect.where('lower(name) = ?', item.downcase).first
          if !val.blank?
            @move.effects_counter_hit << val
          end
        end
      end
      #:effects_block =>       effects_block.map { |p| p.name },
      if !move_dict["effects_block"].blank?
        move_dict["effects_block"].each do |item|
          val = MoveEffect.where('lower(name) = ?', item.downcase).first
          if !val.blank?
            @move.effects_block << val
          end
        end
      end

      #Set parent move
      if !parent_move.blank?
        @move.parent = parent_move
      end
      
      if @move.save
        if !move_dict["child_moves"].blank?

          move_dict["child_moves"].each do |cm|
            save_move_from_dict(cm, @move)
          end
        end

        return @move
      end
  end

  def dict_from_json(json_string)
    begin
      
      parsed_json = JSON.parse json_string

      return parsed_json

    rescue JSON::ParserError
      
      print("Unable to parse json")

      return nil
    end
  end

  def restore_moves

    @stance = Stance.find(params[:selected_stance])

    parsed_json = dict_from_json(params[:moves_json])
    
    if parsed_json != nil
      
      parsed_json.each do |move_dict|
        save_move_from_dict(move_dict, nil)
      end

    else
      flash[:nocice] = "Unable to parse json"
      format.html { render :edit }
      return
    end
    

    respond_to do |format|
      format.html { render :edit }
      # if @move.save
      #   format.html { redirect_to @move, notice: 'Move was successfully created.' }
      #   format.json { render :show, status: :created, location: @move }
      # else

      #   format.html { render :edit }
      #   format.json { render json: @move.errors, status: :unprocessable_entity }
      # end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stance
      @stance = Stance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stance_params
      params.require(:stance).permit(:name, :desc, :character_id)
    end
end
