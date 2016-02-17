

class AccountAppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account_appointment, only: [:show,  :edit, :update, :destroy]
  before_action :owned_account, only: [:show, :edit, :update, :destroy]

  # GET /account_appointments
  def index

    conta = config_session_conta_id

    # Params to Filter in index Page
    start_date = params[:start_date] if params.has_key?(:start_date)
    end_date = params[:end_date] if params.has_key?(:end_date)
    tipo = params[:deb_cre] if params.has_key?(:deb_cre)


    app = current_user.account_appointments.includes(:account)

    if conta

      @account = current_user.accounts.find_by id: conta # Show in the index Filter

      if @account

        session[:conta_id] = @account.id

        app = app.where("account_id = ?", conta)

        app = app.where("date >= ?", start_date) if start_date and not start_date.blank?
        app = app.where("date <= ?", end_date) if end_date and not end_date.blank?
        app = app.where("deb_cre = ?", tipo) if tipo and not tipo.blank?

        @accounts_appointments = app.order(date: :desc, id: :desc).page(params[:page])

      else
        flash[:alert] = "Esta conta não pertence a você!"
        redirect_to accounts_path
      end

    end

  end

  # GET /account_appointments/1
  def show

    conta = config_session_conta_id

  end

  # GET /account_appointments/new
  def new
    # @account = current_user.Account.all
    @account_appointment = AccountAppointment.new

    if params.has_key?(:type_app)
      type_app = params[:type_app]
      case type_app
        when 'D'
          @account_appointment = AccountAppointment.new(:deb_cre => 'C', :description => 'DEPÓSITO')

        when 'S'
          @account_appointment = AccountAppointment.new(:deb_cre => 'D', :description => 'SAQUE')
      end
    end

  end

  # GET /account_appointments/1/edit
  def edit
  end

  # POST /account_appointments
  def create
    @account_appointment = AccountAppointment.new(account_appointment_params)

    if @account_appointment.save
      redirect_to account_appointments_path, notice: 'Lançamento realizado com sucesso!'
    else
      render :new
    end
  end

  def create_and_new
    @account_appointment = AccountAppointment.new(account_appointment_params)

    if @account_appointment.save
      redirect_to new_account_appointment_path, notice: 'Lançamento realizado com sucesso!'
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

  def config_session_conta_id

    if params.has_key?(:conta_id)
      conta = params[:conta_id]

      if session[:conta_id] != conta
        session[:conta_id] = conta
      end
    else
      conta = session[:conta_id]
    end

    return conta
  end

end
