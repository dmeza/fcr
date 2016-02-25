class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def action_missing(provider)
    if !User.omniauth_providers.index(provider.to_sym).nil?
      omniauth = request.env["omniauth.auth"]
      authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
      if authentication
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
        sign_in_and_redirect(:user, authentication.user)
      elsif current_user
        current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => (omniauth['credentials'] && omniauth['credentials']['token']))
        user.apply_omniauth(omniauth)
        flash[:notice] = "Authentication successful."
        redirect_to root_url
      else
        user = omniauth['info']['email'].blank? ? User.new : User.find_or_initialize_by_email(omniauth['info']['email'])
        user.apply_omniauth(omniauth)
        user.confirm!
        if (user.save)
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
          sign_in_and_redirect(:user, user)
        else
          session["devise.omniauth"] = omniauth.except('extra')
          redirect_to new_user_registration_url
        end
      end
    end
  end
end