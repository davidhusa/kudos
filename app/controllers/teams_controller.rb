class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy, :quit, :join]
  before_action :authenticate_user!
  before_action :make_account_if_needed

  def quit
    AccountsTeam.find_by(account_id: current_account.id, team_id: @team.id).destroy
    redirect_to teams_url, notice: "Quit team #{@team.name}"
  end

  def join
    at = AccountsTeam.find_or_create_by(account_id: current_account.id, team_id: @team.id)
    redirect_to teams_url, notice: "Joined team #{@team.name}"
  end

  def index
    @teams = Team.all
  end

  def show
  end

  def new
    @team = Team.new
  end

  def edit
  end

  def create
    @team = Team.new(team_params)
    @team.leader_id = current_account.id

    if @team.save
      redirect_to @team, notice: 'Team was successfully created.'
    else
      render :new
    end
  end

  def update
    if @team.update(team_params) 
      redirect_to @team, notice: 'Team was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @team.destroy
    redirect_to teams_url, notice: 'Team was successfully destroyed.'
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:name, :start_date, :sprint_days)
    end
end
