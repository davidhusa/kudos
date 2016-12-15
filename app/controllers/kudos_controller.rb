class KudosController < ApplicationController
  before_action :set_kudo, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :make_account_if_needed

  def index
    @kudos = Kudo.all
  end

  def show
  end

  def new
    @kudo = Kudo.new
  end

  def edit
  end

  def create
    @kudo = Kudo.new(kudo_params)

    if @kudo.save_if_applicable
      redirect_to @kudo, notice: 'Kudo was successfully created.'
    else
      render :new
    end
  end

  def update
      if @kudo.update(kudo_params)
        redirect_to @kudo, notice: 'Kudo was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @kudo.destroy
      redirect_to kudos_url, notice: 'Kudo was successfully destroyed.'
  end

  private
    def set_kudo
      @kudo = Kudo.find(params[:id])
    end

    def kudo_params
      params.require(:kudo).permit(:to_id, :from_id, :comment)
    end
end
