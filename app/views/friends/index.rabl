collection :@friends

attribute :id, :name

node(:image) do |user|
  user.image.present? ? user.image.file_url : ""
end

