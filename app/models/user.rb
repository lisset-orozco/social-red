# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  username               :string           default(""), not null
#  name                   :string
#  last_name              :string
#  bio                    :text
#  uid                    :string
#  provider               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  cover_file_name        :string
#  cover_content_type     :string
#  cover_file_size        :integer
#  cover_updated_at       :datetime
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, :omniauth_providers => [:facebook]
  
  # no puede ser nulo ni cadena vacía "", que sea único
  validates :username, presence: true, uniqueness: true, length: { in: 3..12 }
  validate :validate_username_regex
  # acceptance => :terminos_y_condiciones, true 
  # Numericality => float, enteros
  # validates :edad, numericality: { only_integer: true } 
  # validates :precio, numericality: true 

  has_many :posts # un usuario puede tener muchos posts

  has_attached_file :avatar, styles: { thumb: "100x100>", medium: "300x300>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_attached_file :cover, styles: { thumb: "400x300>", medium: "800x600>" }, default_url: "/images/:style/missing_cover.jpg"
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/

  # todas las amistades que he agregado
  has_many :friendships  # todas las amistades en las que el user soy yo

  has_many :followers, class_name: Friendship, foreign_key: "friend_id"
  # todos los que me agregaron (en las que yo soy el friend_id)

  has_many :friends_added, through: :friendships, source: :friend 
  # todos los amigos a los que he agregado

  has_many :friends_who_added, through: :friendships, source: :user # los user que me han agregado
  # los amigos que me agregaron

  def friend_ids
    # soy el user y obtengo los friend_id de los que agregué
    Friendship.active.where(user:self).pluck(:friend_id)
    # SELECT friend_id FROM friendships WHERE user_id = 17
  end
  # pluck(columna) retorna un array
  def user_ids
    # soy el friend y obtengo el user_id
    Friendship.active.where(friend:self).pluck(:user_id) 
    # SELECT user_id FROM friendships WHERE friend_id = 17
  end

  def unviewed_notifications_count
    Notification.for_user(self.id)
  end

  # busca si el usuario existe
  def self.from_omniauth(auth)
    # puts auth
    # where(provider: auth[:provider], uid: auth[:uid]).first_or_create do |user| -NO
    where(provider: auth["provider"], uid: auth["uid"]).first_or_create do |user|
      if auth[:info]
        user.email = auth[:info][:email]
        user.name = auth[:info][:name]
      end

      user.password = Devise.friendly_token[0,20]
      # permite crear una cadena que contenga caracteres aleatorios
    end
  end

  def my_friend?(friend)
    Friendship.friends?(self, friend)
  end

  private
  def validate_username_regex
    unless username =~ /\A[a-zA-Z]*[a-zA-Z][a-zA-Z0-9_]*\z/
      errors.add(:username, "El username debe iniciar con una letra y contener sólo letras, números y guión bajo.")
    end
  end
end
 
