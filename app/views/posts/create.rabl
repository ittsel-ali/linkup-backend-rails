collection :@post
attributes :text, :id, :author, :author_image, :time

node(:image) do |post|
  post.image.present? ? post.image.file.url : ""
end

node(:total_comments) do |post|
  post.comments.count
end

child(:comments) {
  attributes :text, :author, :author_image
}

