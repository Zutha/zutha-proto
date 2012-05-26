class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all
  
  helper_method :admin?

	protected

	def authorize
		unless admin?
			flash[:error] = "Unauthorized Access"
			redirect_to root_path
			false
		end
	end

  def admin?
  	user_signed_in? && current_user.admin
  end
end
