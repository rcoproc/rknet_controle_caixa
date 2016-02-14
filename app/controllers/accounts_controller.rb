class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :owned_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts

  def index
    @accounts = initialize_grid(current_user.accounts)
  end

  # GET /accounts/1
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new(:user_id => current_user.id)
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  def create
    @account = Account.new(account_params)

    if @account.save
      redirect_to @account, notice: 'Conta inserida com sucesso!'
    else
      render :new
    end
  end

  # PATCH/PUT /accounts/1
  def update
    if @account.update(account_params)
      redirect_to @account, notice: 'Conta atualizada com sucesso!'
    else
      render :edit
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy
    redirect_to accounts_url, notice: 'Account was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def account_params
      params.require(:account).permit(:name, :bank, :bank_office, :initial_balance, :active, :user_id)
    end

    def owned_account
      @account = Account.find(params[:id])
      unless current_user == @account.user
        flash[:alert] = "Esta conta não pertence a você!"
        redirect_to root_path
      end
    end
end
