require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'requires name' do
    user = User.create(name: nil)
    # binding.pry
    # puts user.errors
    assert user.errors[:name].any?
  end

  test 'requires e-mail' do
    user = User.create(email: '')
    assert user.errors[:email].any?
  end

  test 'requires valid email' do
    user = User.create(email: 'invalid')
    assert user.errors[:email].any?
  end

  %w[
    a@a.a
    a..@example.org
    a..a@example.org
  ].each do |email|
    test "requires valid email (#{email})" do
      user = User.create(email: email)
      assert user.errors[:email].any?
    end
  end

  %w[
    john@example.com
    john.doe@example.com
    JOHN@EXAMPLE.COM
  ].each do |email|
      test "accepts valid email (#{email})" do
        user = User.create(email: email)
        assert user.errors[:email].empty?
      end
  end

  test 'requires_password' do
    user = User.create(password: '')
    assert user.errors[:password].any?
  end

  test 'requires password confirmation' do
    user = User.create(password: 'test', password_confirmation: 'invalid')
    assert user.errors[:password_confirmation].any?
  end

  # Dada uma entrada , a saida é a saída esperada ??

end
