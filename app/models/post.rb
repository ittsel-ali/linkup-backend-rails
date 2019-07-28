class Post < ApplicationRecord
  belongs_to :user

  has_many :comments
  has_one :image, as: :imagable

  accepts_nested_attributes_for :image

  def author
    self.user.name
  end

  def author_image
    self.user.photo
  end

  def time
    self.created_at.strftime("%B %d, %Y")
  end
end
