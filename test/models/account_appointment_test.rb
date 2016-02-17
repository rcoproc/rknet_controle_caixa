require 'test_helper'

class AccountAppointmentTest < ActiveSupport::TestCase
  test 'requires Account Appointment Date' do
    app = AccountAppointment.create(date: nil)
    assert app.errors[:date].any?
  end

  test 'requires Account Appointment Description' do
    app = AccountAppointment.create(description: nil)
    assert app.errors[:description].any?
  end

  test 'requires Account Appointment Value' do
    app = AccountAppointment.create(value: nil)
    assert app.errors[:value].any?
  end

  test 'requires Account Appointment Debits/Credits' do
    app = AccountAppointment.create(deb_cre: nil)
    assert app.errors[:deb_cre].any?
  end

  test 'requires Account Appointment Value greater then Zero' do
    app = AccountAppointment.create(value: -10)
    assert app.errors[:value].any?
  end

  test 'requires Invalid Account id' do
    app = AccountAppointment.create(account_id: 9999)
    assert app.errors[:account].any?
  end

  test 'requires Valid Account id' do
    account = accounts(:bra)
    app = AccountAppointment.create(account_id: account.id)
    assert !app.errors[:account].any?
  end

  test 'requires Insuficient Balance' do
    account = accounts(:bra)

    app = AccountAppointment.create( date: Date.current, account_id: account.id, description: 'TEST',  deb_cre: 'D', value: 100000)
    assert app.errors[:value].any?

  end

  test 'requires Suficient Balance' do
    account = accounts(:bra)

    app = AccountAppointment.create( date: Date.current, account_id: account.id, description: 'TEST',  deb_cre: 'D', value: 10)
    assert !app.errors[:value].any?

  end

end
