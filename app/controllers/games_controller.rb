class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy, :make_bet]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
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

    respond_to do |format|
      if @game.save
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

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def make_bet
    dice_roll = rand 1..6
    bet =   params["bet"].to_i
    guess =   params["guess"].to_i
    statement = ["You sand-bagging son of a b.", " I fart in your general direction! Your mother was a hamster and your father smelt of elderberries!", "You lose, have you tried turning it off and on again?", "You scruffy nerfherder.", "You clanking, clattering collection of caliginous junk!"]

    if dice_roll == guess
      redirect_to @game, notice: 'You guessed correctly.'
      @game.update(chips: @game.chips + bet)
    else
      redirect_to @game, notice: "#{statement.sample} The computer rolled #{dice_roll}"
      @game.update(chips: @game.chips - bet)
    end

  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:chips)
    end
end
