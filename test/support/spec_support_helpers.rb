
module HelperMethods
  def logout_user(user = @current_user)
    Capybara.reset_sessions!
    # visit destroy_user_session_path
  end

  def login_with_valid_user
    visit '/users/sign_in'

    fill_in 'Email', :with => 'rcoproc@gmail.com'
    fill_in 'user_password', :with => '12345678'

    click_button 'Entrar'
  end

end