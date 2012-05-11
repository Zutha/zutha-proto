class Users::SessionsController < Devise::SessionsController

  # GET /sign_in
  def new
  	logger.debug "\n running new in users/SessionsController"
  end

  # POST /sign_in
  def create
  	logger.debug "\n running create in users/SessionsController.\n"
  	super
  end

  # DELETE /sign_out
  def destroy
  	logger.debug "\n running destroy in users/SessionsController"
    super
  end


end