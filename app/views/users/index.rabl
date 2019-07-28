collection :@users

attribute :id, :name

node(:image) do |user|
  user.photo
end