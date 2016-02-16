class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.]
  before_filter :get_current_accounts
  protect_from_forgery with: :exception

  # @user_account = current_user.accounts
  def get_current_accounts
    if current_user
      @user_account = current_user.accounts
    end
  end

end
