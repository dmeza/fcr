module ControllerHelpers

  def sign_in(user = double('user'), account = double('account'), permitted = true, permission = :manage, target = :all)
    # ability = Object.new
    # ability.extend(CanCan::Ability)
    # permitted ? ability.can(permission, target) : ability.cannot(permission, target)
    # allow(controller).to receive(:current_ability) { ability }

    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
      allow(controller).to receive(:current_user).and_return(nil)
    else
      allow(user).to receive(:timezone?).and_return(true)
      allow(user).to receive(:timezone).and_return("UTC")
      allow(user).to receive(:has_completed_sign_up?).and_return(true)
      allow(account).to receive(:timezone?).and_return(true)
      allow(account).to receive(:timezone).and_return("UTC")
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:current_account).and_return(account)
    end
  end

  def sign_in_using_token(api_key = double('api_key'))
    if api_key.nil?
      allow(APIKey).to receive(:find_by_access_token).and_return(nil)
    else
      request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials("abc123")
      allow(APIKey).to receive(:find_by_access_token).and_return(api_key)
      allow(api_key).to receive(:authenticatable).and_return(nil)
      allow(controller).to receive(:current_api_key).and_return(api_key)
    end
  end

  def grant_api_key_access_to_resources
    if controller.current_api_key
      ability = Object.new
      ability.extend(CanCan::Ability)
      ability.can(:manage, :all)
      allow(controller).to receive(:current_ability).and_return(ability)
    end
  end

end
