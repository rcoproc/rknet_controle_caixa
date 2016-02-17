require 'test_helper'

class AccountTest < ActiveSupport::TestCase

  test 'requires Account name' do
    account = Account.create(name: nil)
    # binding.pry
    # puts user.errors
    # puts account.errors
    assert account.errors[:name].any?
  end

  test 'requires Bank name' do
    account = Account.create(bank: nil)
    # binding.pry
    # puts user.errors
    assert account.errors[:bank].any?
  end

  test 'requires Bank Office name' do
    account = Account.create(bank_office: nil)
    # binding.pry
    # puts user.errors
    assert account.errors[:bank_office].any?
  end

  test 'requires Initial Balance is greater then ZERO' do
    account = Account.create(initial_balance: -10)
    # binding.pry
    # puts user.errors
    assert account.errors[:initial_balance].any?
  end

  test 'require Stop Account Destroy' do
    ref = Account.first
    account = Account.destroy(ref.id)
    # binding.pry
    # puts user.errors
    assert Account.exists?(ref.id)
  end


  test 'requires Valid User id' do
    user = users(:rco)
    app = Account.create(user_id: user.id)
    assert !app.errors[:user].any?
  end

  test 'requires Invalid User id' do
    app = Account.create(user_id: 99999)
    assert app.errors[:user].any?
  end

end
