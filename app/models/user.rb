class User < ActiveRecord::Base
 
  # :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauth_providers => [:facebook]

  has_many :reviews
  has_many :restaurants
  has_many :reviewed_restaurants, through: :reviews, source: :restaurant
  

def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name   # assuming the user model has a name
  end
end

def has_reviewed?(restaurant)
  reviewed_restaurants.include? restaurant
end

end
