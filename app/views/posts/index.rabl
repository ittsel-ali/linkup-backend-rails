collection :@posts
attributes :text
node(:image) do |post|
  post.image.present? ? post.image.file_url : ""
end
