collection :@friends

attribute :id, :name

node(:image) do |user|
  user.photo
end

