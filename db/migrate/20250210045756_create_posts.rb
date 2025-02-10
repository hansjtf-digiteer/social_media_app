class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.boolean :feature, default: false
      t.boolean :active, default: true
      t.datetime :publish_date

      t.timestamps
    end
    add_index :posts, :title, unique: true
  end
end