class AccountsController < ApplicationController
  before_action :set_account, only: [:update, :destroy]
  before_action :authenticate_user!
  before_action :make_account_if_needed, except: [:edit]
  before_action :admin_only, only: [:index, :destroy]

  def index
    @accounts = Account.all
  end

  def new
    @account = Account.from_user(current_user)
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    if @account.update(account_params)
      redirect_to edit_account_path(@account), notice: 'Account was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      @account.user.destroy
      @account.destroy
    end
    redirect_to accounts_url, notice: 'Account was successfully destroyed.'
  end

  private
    def set_account
      @account = Account.find(params[:id])
    end

    def account_params
      params.require(:account).permit(:name, :photo, :about, :status)
    end
end
