class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :friends, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :tokens, class_name: "Doorkeeper::AccessToken", foreign_key: "resource_owner_id", dependent: :destroy

  has_one :image, as: :imagable, dependent: :destroy


  accepts_nested_attributes_for :image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def search(string)
    users=[]

    friends = self.friends.pluck(:friend_id) + [self.id]

    if string == ":all"
      users = User.where("id NOT IN (?) ", friends)
    elsif string.present?
      users = User.where(" id NOT IN (?) AND (LOWER(first_name) like ? OR LOWER(last_name) like ? )", friends, "%"+string+"%", "%"+string+"%")
    else
      users = User.where("id NOT IN (?) ", friends)
    end

    users.order(id: :desc)
  end       

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
