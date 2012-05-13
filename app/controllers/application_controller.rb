class ApplicationController < ActionController::Base
  protect_from_forgery

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
  	current_user.admin
  end
end
