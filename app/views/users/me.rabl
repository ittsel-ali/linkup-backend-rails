collection :@user

attribute :id, :name, :photo

node(:image) do |user|
  user.photo
end