class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def author
    self.user.name
  end

  def author_image
    self.user.photo
  end
end
