class GamesController < ApplicationController

  skip_before_action :authenticate_user!, :only => [:index, :show]
  #before_action :authenticate_user!, :except => [:show, :index]
  before_action :set_game, only: [:show, :edit, :update, :destroy]


  # GET /games
  # GET /games.json
  def index
    @games = Game.where("end_time >= ?", Time.now)
    @partial = params[:view] || "map"
    if @partial == "map"
      @hash = Gmaps4rails.build_markers(@games) do |game, marker|
        if game.need_players && game.need_count > game.count
          pin = "_pin_gray.png"
        elsif game.start_time < Time.now
          pin = "_pin_green.png"
        elsif game.end_time < Time.now + 1.days
          pin = "_pin_yellow.png"
        else
          pin = "_pin_red.png"
        end

        marker.infowindow render_to_string(:partial => "/games/infowindow", :locals => { :game => game})
        marker.lat game.latitude
        marker.lng game.longitude
        marker.title (game.name + " - " + game.gametype.name)
        marker.picture({
          :url => view_context.image_path(game.gametype.image + pin),
          :width => 32,
          :height => 56
          })
      end
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @attendees = @game.attendees.paginate(page: params[:page])
  end

  # GET /games/new
  def new
    if current_user.games.where("end_time >= ?", Time.now).count >= 3
      redirect_to games_path
      flash[:notice] = "Can't have more than three games"
    end
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
    if current_user != @game.user
      redirect_to games_path
      flash[:notice] = "You don't own that"
    end
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)
    @game.user_id = current_user.id

    respond_to do |format|
      if @game.save
        #UserMailer.example_email(current_user).deliver
        game_added_email(@game, current_user)
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def game_added_email(game, current_user)
    players = game.gametype.users.where.not(id: current_user.id).pluck(:id)
    followers = current_user.followers_by_type('User').pluck(:id)
    users = User.where('id IN (?) OR id IN (?)', players, followers)
    users = users.where(receive: true)
    users.each do |user|
      #Resque.enqueue(Mailjob, user.id, game.id, current_user.id)
      UserMailer.single_game_email(user.id, game.id, current_user.id).deliver
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

  #POST /GET?

  def join
     @game = Game.find(params[:id])
     current_user.attended_events << @game
     @game.update_attributes(:count => @game.count + 1)
     redirect_to @game
  end

  #DELETE?
  def leave
     @game = Game.find(params[:id])
     current_user.attended_events.delete(@game)
     @game.update_attributes(:count => @game.count - 1)
     redirect_to games_url
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    if current_user != @game.user
      redirect_to games_path
      flash[:notice] = "You don't own that"
    end
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
      params.require(:game).permit(:name,:description , :start_time, :end_time, :user_id, :gametype_id, :need_players, :need_count, :latitude, :longitude)
    end
end
