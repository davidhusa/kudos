class AccountsController < ApplicationController
  before_action :set_account, only: [:update, :destroy]
  before_action :authenticate_user!
  before_action :customize_account_if_needed, except: [:edit, :update]
  before_action :admin_only, only: [:index, :destroy]

  def index
    @accounts = Account.all
  end

  def edit
    params[:id] = current_account.id unless admin?
    @account = Account.find(params[:id])
  end

  def update
    params[:id] = current_account.id unless admin?
    if @account.touch && @account.update(account_params)
      redirect_to edit_account_path(@account), notice: 'Account was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      @account.destroy
      @account.user.destroy
    end
    redirect_to teams_url, notice: 'Account was successfully destroyed.'
  end

  private
    def set_account
      params[:id] = current_account.id unless admin?
      @account = Account.find(params[:id])
    end

    def account_params
      params.require(:account).permit(:name, :photo, :about, :status)
    end
end
