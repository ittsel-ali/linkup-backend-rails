class Timeline < ApplicationRecord
  def self.get_friends_posts(user)
    Post.where("posts.user_id in 
      (SELECT friends.friend_id 
      FROM users INNER JOIN friends 
      ON users.id = friends.user_id WHERE users.id = ?) 
      OR posts.user_id = ?", user.id, user.id)
  end
end
