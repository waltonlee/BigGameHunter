class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
    @partial = params[:view] || "map"
    if @partial == "map"
      @hash = Gmaps4rails.build_markers(@games) do |game, marker|
        marker.infowindow "<p> 
          Name: #{game.name} <br />
          Creator: #{game.user.name} <br />
          Start: #{game.start} <br />
          End: #{game.end}
          </p>"
        marker.lat game.latitude
        marker.lng game.longitude
        marker.picture({
          :url => view_context.image_path(game.gametype.image + "_pin_red.png"),
          :width => 32,
          :height => 56
          })
      end
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)
    @game.user_id = current_user.id 

    respond_to do |format|
      if @game.save
        UserMailer.example_email(current_user).deliver
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  #POST
  def join
     @game = Game.find(params[:id])
     current_user.attended_events << @game
     redirect_to @game
  end

  #DELETE?
  def leave
     @game = Game.find(params[:id])
     current_user.attended_events.delete(@game)
     redirect_to games_url
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:name, :start, :end, :user_id, :gametype_id, :latitude, :longitude)
    end
end
