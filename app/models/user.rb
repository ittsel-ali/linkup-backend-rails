class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :friends
  has_many :posts
  has_many :tokens, class_name: "Doorkeeper::AccessToken", foreign_key: "resource_owner_id"

  has_one :image, as: :imagable, dependent: :destroy


  accepts_nested_attributes_for :image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



  class << self
    def authenticate(email, password)
      user = User.find_for_database_authentication(:email => email)

      if user&.valid_for_authentication? { user.valid_password?(password) } && user&.active_for_authentication?
        user
      end
     end
  end

  def name
    self.first_name.to_s+" "+self.last_name.to_s
  end

  def friend_list(status)
    friends_ids = self.friends.where(active?: status).pluck(:friend_id)
    User.where(id: friends_ids)
  end

  def photo
    self.image.present? ? self.image.file_url : "https://i1.wp.com/www.molddrsusa.com/wp-content/uploads/2015/11/profile-empty.png.250x250_q85_crop.jpg?ssl=1"
  end
end
