

class AccountAppointmentsController < ApplicationController
  before_action :set_account_appointment, only: [:show,  :edit, :update, :destroy]
  before_action :owned_account, only: [:show, :edit, :update, :destroy]

  # GET /account_appointments
  def index


    if params.has_key?(:conta_id)
      conta = params[:conta_id]

      if session[:conta_id] != conta
        session[:conta_id] = conta
      end
    else
      conta = session[:conta_id]
    end

    date = params[:date] if params.has_key?(:date)
    tipo = params[:deb_cre] if params.has_key?(:deb_cre)


    app = current_user.account_appointments.includes(:account)

    if conta

      @account = current_user.accounts.find_by id: session[:conta_id] # Show in the index Filter

      if @account

        session[:conta_id] = @account.id

        app = app.where("account_id = ?", conta)

        app = app.where("date <= ?", date) if date and not date.blank?
        app = app.where("deb_cre = ?", tipo) if tipo and not tipo.blank?

        @accounts_appointments = app.order(date: :desc, deb_cre: :desc, id: :desc)
      else
        flash[:alert] = "Esta conta não pertence a você!"
        redirect_to accounts_path
      end

    end

  end

  # GET /account_appointments/1
  def show
  end

  # GET /account_appointments/new
  def new
    # @account = current_user.Account.all
    @account_appointment = AccountAppointment.new
  end

  # GET /account_appointments/1/edit
  def edit
  end

  # POST /account_appointments
  def create
    @account_appointment = AccountAppointment.new(account_appointment_params)

    if @account_appointment.save
      redirect_to account_appointments_path, notice: 'Lançamento inserido com sucesso!'
    else
      render :new
    end
  end

  def create_and_new
    @account_appointment = AccountAppointment.new(account_appointment_params)

    if @account_appointment.save
      redirect_to new_account_appointment_path, notice: 'Lançamento inserido com sucesso!'
    else
      render :new
    end
  end


  # PATCH/PUT /account_appointments/1
  def update
    if @account_appointment.update(account_appointment_params)
      redirect_to @account_appointment, notice: 'Lançamento da conta realizado com Sucesso!'
    else
      render :edit
    end
  end


  # DELETE /account_appointments/1
  def destroy
    conta_id = @account_appointment.account_id
    @account_appointment.destroy
    redirect_to account_appointments_url, notice: 'Lançamento excluido com Sucesso!'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_appointment
      @account_appointment = AccountAppointment.find(params[:id])

    end

    # Only allow a trusted parameter "white list" through.
    def account_appointment_params
      params.require(:account_appointment).permit(:account, :date, :description, :document, :deb_cre, :value, :account_id)
    end

  def owned_account
    @account = Account.find(params[:conta_id]) if params.has_key?(:conta_id)
    unless current_user == @account_appointment.account.user
      flash[:alert] = "Esta conta não pertence a você!"
      redirect_to accounts_path
    end
  end
end
