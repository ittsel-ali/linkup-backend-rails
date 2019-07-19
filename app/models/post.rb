class Post < ApplicationRecord
  has_many :comments
  has_one :image, as: :imagable

  accepts_nested_attributes_for :image
end
