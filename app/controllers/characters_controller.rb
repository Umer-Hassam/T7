class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]
  # DEVISE CHECK
  before_action :authenticate_user!, :only => [:new, :edit, :create, :destroy]

  before_action :check_character_status, :only => [:show]

  def check_character_status
    redirect_to(root_path) unless (@character.publish.to_i == 1 || user_signed_in?)
  end
  
  # GET /characters
  # GET /characters.json
  def index

    if !user_signed_in?
      @characters = Character.where.not(publish:"-1")
    else
      @characters = Character.all
    end

    if !params[:sort].blank?
      
      if params[:sort] == "tier"
        @characters = @characters.sort_by{ |c| ["S++", "S+", "S","A", "B", "C"].index(c.tier) }
      elsif params[:sort] == "diff"
        @characters = @characters.sort_by{ |c| ["5/5", "4/5", "3/5","2/5", "1/5"].index(c.difficulty) }
      else
        @characters = @characters.sort_by{ |c| c.name }
      end

    else
      @characters = @characters.sort_by{ |c| c.name }
    end
    
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
  end

  # GET /characters/new
  def new
    @character = Character.new
  end

  # GET /characters/1/edit
  def edit
  end

  # POST /characters
  # POST /characters.json
  def create
    @character = Character.new(character_params)
    
    respond_to do |format|
      if @character.save
        
        if params[:create_without_stances] == nil
          
          # Create Related Stances
          ["Standing", 
            "Full Crouch", 
            "While Standing", 
            "While Running",
            "Back Turned",
            "Side Step Right",
            "Side Step Left",
            "On Ground (Face Up Feet towards)", 
            "On Ground (Face Down Feet towards)", 
            "On Ground (Face Up Feet away)", 
            "On Ground (Face Down Feet away)"].each do |stanceName|
            
              stance = @character.stances.create(name:stanceName)
              
              if if params[:create_without_moves] == nil
                if stanceName == "Standing" || stanceName == "While Standing"
                  ["1","2","3","4","1+2","3+4"].each do |moveInput|
                    Move.create(name:stanceName+" "+moveInput, input:moveInput, character:@character, stance:stance).save!
                  end
                end
            
                if stanceName == "Standing"
                  ["f,1", "b,1", "d,1", "df,1",
                    "f,2","b,2", "d,2", "df,2",
                    "f,3","b,3", "d,3",
                    "f,4","b,4", "d,4", "uf,4"].each do |mi|
          
                    Move.create(name:stanceName+" "+mi, input:mi, character:@character, stance:stance).save!
                  end
                end
              end
              end
          end
        end
        
        format.html { redirect_to @character, notice: 'Character was successfully created.' }
        format.json { render :show, status: :created, location: @character }
        
      else
        format.html { render :new }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /characters/1
  # PATCH/PUT /characters/1.json
  def update
    respond_to do |format|
      if @character.update(character_params)
        format.html { redirect_to @character, notice: 'Character was successfully updated.' }
        format.json { render :show, status: :ok, location: @character }
      else
        format.html { render :edit }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /characters/1
  # DELETE /characters/1.json
  def destroy
    @character.destroy
    respond_to do |format|
      format.html { redirect_to characters_url, notice: 'Character was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      @character = Character.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def character_params
      params.require(:character).permit(:name, :wiki_link, :full_image_link, :thumb_image_link, :gameplay, :fighting_style, :archetype, :difficulty, :tier, :publish, :strengths, :weaknesses, :movement)
    end
end
