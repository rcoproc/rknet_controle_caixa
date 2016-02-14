require 'test_helper'


class SignTest < ActionDispatch::IntegrationTest
  include HelperMethods

  #fixtures :all

  # background do
  #   User.make(:email => 'rcoproc@gmail.com', :password => '12345678')
  # end

  test 'with valid data' do

    logout_user

    visit '/users/sign_up'

    fill_in 'user_name', :with => 'Ricardo'
    fill_in 'Email', :with => 'ricardo@rcop.com.br'
    fill_in 'user_password', :with => '12345678'
    fill_in 'user_password_confirmation', :with => '12345678'

    click_button 'Sign up'

    # require 'pry'; binding.pry

    # print page.html


    assert_equal '/', current_path
    assert page.has_text?('Bem-vindo')

  end

  test 'with valid login' do

    logout_user

    login_with_valid_user

    # expect(page).to have_content 'Logado com sucesso' # or
    assert_equal '/', current_path

    # save_and_open_page

    assert page.has_text?('Logado com sucesso')

  end

  test 'logged and correct search' do

    logout_user

    login_with_valid_user

    # expect(page).to have_content 'Logado com sucesso' # or
    assert_equal '/', current_path

    visit '/'

    fill_in 'grid_f_bank', :with => 'BB'
    click_button 'Filtrar'


    # save_and_open_page

    assert_equal '/', current_path

    # descobrir como pegar um registro da tabela

  end

  test 'with invalid valid data' do

    logout_user

    visit '/users/sign_up'

    fill_in 'user_name', :with => ''
    fill_in 'Email', :with => 'ricardo'
    fill_in 'user_password', :with => '12345678'
    fill_in 'user_password_confirmation', :with => '123'

    click_button 'Sign up'

    # require 'pry'; binding.pry

    # print page.html

    # save_and_open_page

    assert_equal '/users', current_path
    assert page.has_text?('erro')

  end

  test 'with invalid valid login' do

    logout_user

    visit '/users/sign_in'

    assert_equal '/users/sign_in', current_path

    fill_in 'user_email', :with => 'rcoproc'
    fill_in 'user_password', :with => '99999'

    click_button 'Entrar'

    # expect(page).to have_content 'Login inválido' # or
    assert_equal '/users/sign_in', current_path

    assert page.has_text?('inválido')
  end

end
