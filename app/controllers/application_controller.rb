class ApplicationController < ActionController::Base
  helper_method :current_user_order

  def current_user_order
    current_user&.orders&.find_by(status: 'new')
  end
end
