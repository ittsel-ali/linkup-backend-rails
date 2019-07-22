class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :friends
  has_many :posts
  
  has_one :image, as: :imagable


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

  def friend_list
    User.where(id: self.friends.pluck(:friend_id))
  end
end
