class KudosController < ApplicationController
  before_action :set_kudo, only: [:show, :edit, :update, :destroy]
  before_action :set_team

  before_action :authenticate_user!
  before_action :customize_account_if_needed
  before_action :control_edit_access!, only: [:update, :edit, :destroy]

  def index
    @kudos = Kudo.where(sprint: @team.sprint).all.reverse

    @members = @team.accounts
  end

  def new
    @kudo = Kudo.new
  end

  def edit
  end

  def create
    @kudo = Kudo.new(kudo_params)
    @kudo.from_id = current_account.id
    @kudo.team_id = @team.id
    @kudo.sprint  = @team.sprint

    if @kudo.save_if_applicable(current_account)
      redirect_to team_kudos_path(@team), notice: 'Kudo was successfully created.'
    else
      flash[:alert] = @kudo.errors.values.join(", ")
      redirect_to team_kudos_path(@team)
    end
  end

  def update
      if @kudo.update(kudo_params)
        redirect_to team_kudos_path(@team), notice: 'Kudo was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @kudo.destroy
    redirect_to team_kudos_url(@team), notice: 'Kudo was successfully destroyed.'
  end

  private
    def set_kudo
      @kudo = Kudo.find(params[:id])
    end

    def set_team
      @team = Team.find(params[:team_id])
    end

    def kudo_params
      params.require(:kudo).permit(:to_id, :comment)
    end

    def control_edit_access!
      unless admin? || leader?(@kudo.team)
        flash[:error] = "Unauthorized edit"
        redirect_to team_kudos_path(@kudo)
      end
    end
end
