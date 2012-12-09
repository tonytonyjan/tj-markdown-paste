class User
  module OmniauthCallbacks
    Setting.providers.each do |provider|
      define_method "find_or_create_for_#{provider}" do |response|
        uid = response["uid"]
        data = response["info"]

        if user = User.includes(:authorizations).where("authorizations.provider" => provider, "authorizations.uid" => uid).first
          user
        elsif user = User.find_by_email(data["email"])
          user.bind_service(response)
          user
        else
          user = User.new_from_provider_data(provider, uid, data)

          if user.save!(:validate => false)
            user.authorizations << Authorization.new(:provider => provider, :uid => uid)
            return user
          else
            Rails.logger.warn("User.new_from_provider_data failed. #{user.errors.inspect}")
            return nil
          end
        end
      end
    end
    def new_from_provider_data(provider, uid, data)
      User.new do |user|
        user.email = data["email"]
        user.email = "twitter+#{uid}@example.com" if provider == "twitter"
        user.name = data["name"]
        user.password = Devise.friendly_token[0, 20]
        user.confirmed_at = Time.now()
        user.confirmation_token = nil
      end
    end
  end
end
