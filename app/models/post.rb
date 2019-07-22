class Post < ApplicationRecord
  belongs_to :user

  has_many :comments
  has_one :image, as: :imagable

  accepts_nested_attributes_for :image

  def author
    self.user.name
  end
end
