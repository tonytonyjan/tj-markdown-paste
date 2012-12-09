class User < ActiveRecord::Base
  extend OmniauthCallbacks
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :provider, :uid
  # attr_accessible :title, :body

  has_many :posts, dependent: :destroy
  has_many :authorizations, :dependent => :destroy

  def gravatar_url
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}"
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create!(name:auth.extra.raw_info.name,
                          provider:auth.provider,
                          uid:auth.uid,
                          email:auth.info.email,
                          password:Devise.friendly_token[0, 20])
      user.confirmed_at = Time.now()
      user.confirmation_token = nil
      user.save!
    end
    user
  end

  def bind_service(response)
    provider = response["provider"]
    uid = response["uid"]
    authorizations.find_or_create_by_provider_and_uid!(provider, uid)
  end

  def can_bind_to
    Setting.providers - (self.authorizations.map {|auth| auth.provider})
  end
end
