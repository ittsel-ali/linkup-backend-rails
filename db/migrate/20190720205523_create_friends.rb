class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|

      t.belongs_to :user
      t.bigint :friend_id
      t.timestamps
    end
  end
end
