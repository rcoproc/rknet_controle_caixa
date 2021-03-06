class Account < ActiveRecord::Base
  include ModelUtil
  default_scope { where(active: true) }

  belongs_to :user
  has_many   :account_appointments, foreign_key: 'account_id', dependent: :destroy


  validates_presence_of :user_id, :name, :bank, :bank_office
  validates             :user, presence: true
  validates             :initial_balance, :numericality => { :greater_than => 0, message: 'deverá ser um valor maior que ZERO.'}
  before_destroy        :stop_account_destroy, prepend: true

  def debits
    AccountAppointment.where(:account_id => id, :deb_cre => 'D').sum(:value)
  end

  def credits
    AccountAppointment.where(:account_id => id, :deb_cre => 'C').sum(:value)
  end

  def balance
    bal = initial_balance - debits + credits
    # money_number_br(bal)
  end

  def balance_br
    ActionController::Base.helpers.number_to_currency(balance)
  end

  def initial_balance_br
    ActionController::Base.helpers.number_to_currency(initial_balance)
  end

  def prev_balance(date, app_id)

    debs =  AccountAppointment.where(:account_id => id, :deb_cre => 'D').where('account_appointments.date <= ?', date).where('account_appointments.id <?', app_id).order(date: :desc, deb_cre: :desc).sum(:value)
    cres =  AccountAppointment.where(:account_id => id, :deb_cre => 'C').where('account_appointments.date <= ?', date).where('account_appointments.id <?', app_id).order(date: :desc, deb_cre: :desc).sum(:value)


    calc = initial_balance - debs + cres

    # require "pry"; binding.pry

    # ActionController::Base.helpers.number_to_currency(calc)

  end

  protected

  def stop_account_destroy
    errors.add(:name, "Esta conta não pode ser excluida!")
    false
  end

end
