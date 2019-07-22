collection :@user

attribute :id, :first_name, :last_name, 

node(:image) do |user|
  user.image.present? ? user.image.file_url : ""
end