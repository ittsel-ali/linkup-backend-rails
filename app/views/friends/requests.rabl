collection :@friend_requests

attribute :id, :name

node(:image) do |user|
  user.image.present? ? user.image.file_url : "https://i1.wp.com/www.molddrsusa.com/wp-content/uploads/2015/11/profile-empty.png.250x250_q85_crop.jpg?ssl=1"
end

