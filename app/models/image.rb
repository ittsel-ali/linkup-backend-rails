class Image < ApplicationRecord
  mount_uploader :file, AvatarUploader

  belongs_to :imagable, polymorphic: true
end
