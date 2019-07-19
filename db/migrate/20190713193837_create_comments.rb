class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.belongs_to :post
      t.string :text

      t.timestamps
    end
  end
end
