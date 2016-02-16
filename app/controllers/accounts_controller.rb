require 'util/appointments'

class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy, :transfer, :clousure]
  before_action :set_account_to_transfers, only: [:show, :transfer]
  before_action :owned_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts

  def index

    # Wice Grid Initializer
    @accounts = initialize_grid(current_user.accounts.order(:bank, :bank_office, :name),
    name: 'grid',
    enable_export_to_csv: true,
    csv_field_separator: ',',
    csv_file_name: 'contas')

    export_grid_if_requested('grid' => 'grid')
  end

  # GET /accounts/1
  def show
    @transfer = current_user.accounts.where.not(id: params[:id])
  end

  # GET /accounts/new
  def new
    @account = Account.new(:user_id => current_user.id)
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST/transfer
  def transfer

    @conta_dest     = current_user.accounts.find(params[:conta_dest_id])

    @aconta_origem  = current_user.accounts.find(params[:id])

    saldo_origem = @aconta_origem.balance

    value_debt = params[:value].to_d

    if (value_debt > 0)
      if (value_debt <= saldo_origem)

        msg = AppTransfer.call(params[:id],params[:conta_dest_id], value_debt)

        redirect_to accounts_path, notice: msg

      else

        flash.now[ :alert ] = 'Saldo indisponível para esta operação!'
        render :show

      end
    end

  end

  # POST /accounts
  def create
    @account = current_user.accounts.new(account_params)

    if @account.save
      redirect_to @account, notice: 'Conta inserida com sucesso!'
    else
      render :new
    end
  end

  # POST/Closure
  def clousure

    if @account.update( active: false )
      flash[ :success ] = 'Conta ENCERRADA com sucesso!'
    else
      flash[ :alert ] = 'Conta NÁO foi encerrada!'
    end
    redirect_to accounts_path

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
      @account = current_user.accounts.find(params[:id])
    end

    def set_account_to_transfers
      @transfer = current_user.accounts.where.not(id: params[:id]).where(active: true).order(:name)
    end

    # Only allow a trusted parameter "white list" through.
    def account_params
      params.require(:account).permit(:name, :bank, :bank_office, :initial_balance, :active)
    end

    def owned_account
      @account = Account.find(params[:id])
      unless current_user == @account.user
        flash[:alert] = "Esta conta não pertence a você!"
        redirect_to root_path
      end
    end
end
