class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, 
         :omniauth_providers => [:google_oauth2]

  
        
 # Otros modelos y relaciones
 followability    
 acts_as_voter
 has_many :posts
 has_many :comments
 has_one_attached :user_photo
 has_one_attached :cover
 has_many :notifications, as: :recipient, dependent: :destroy
 # Validación personalizada para una contraseña segura
 validate :strong_password, on: :create

# Validación personalizada para una contraseña segura
 def self.from_omniauth(access_token)
  user = User.where(email: access_token.info.email).first

  unless user
    user = User.new(
      email: access_token.info.email,
      password: Devise.friendly_token[0, 20]
    )
  end

  user.name = access_token.info.name
  user.uid = access_token.uid
  user.provider = access_token.provider
  user.save

  user
end

 # Validación de contraseña segura
  def strong_password
    return if password.blank?

    unless password.match?(/[A-Z]/) && password.match?(/[a-z]/)
      errors.add(:password, 'debe contener al menos una letra mayúscula y una letra minúscula.')
    end
  end

end
