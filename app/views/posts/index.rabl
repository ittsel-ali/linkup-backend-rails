collection :@posts
attributes :text, :id, :author

node(:image) do |post|
  post.image.present? ? post.image.file_url : ""
end

node(:total_comments) do |post|
  post.comments.count
end

child(:comments) {
  attributes :text
}

