class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def failure
    super
  end

  def open_id
    user = User.find_for_open_id(access_token)
    log_in_user(user, "OpenID")
  end

  def google_openid
    user = User.find_for_open_id(access_token)
    log_in_user(user, "Google")
  end

  def google_oauth2
    user = User.find_for_google_oauth(access_token)
    log_in_user(user, "Google")
  end

  def facebook
    user = User.find_for_facebook_oauth(access_token)
    log_in_user(user, "Facebook")
  end
  
  def windowslive
    user = User.find_for_windowslive_oauth(access_token)
    log_in_user(user, "Windows Live")
  end

protected
  
  def access_token 
    request.env["omniauth.auth"] 
  end

  def log_in_user(user, provider_name)
    if user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => provider_name
      sign_in_and_redirect user, :event => :authentication
    else
      session["devise.omniauth_data"] = access_token
      redirect_to new_user_registration_url
    end
  end
end