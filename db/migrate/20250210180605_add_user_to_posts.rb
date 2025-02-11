# db/migrate/20250210180605_add_user_to_posts.rb
class AddUserToPosts < ActiveRecord::Migration[7.0]
  def up
    # Add user_id column
    add_reference :posts, :user, null: true, foreign_key: true
    
    # Create default user
    User.create!(
      email: 'admin@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
    
    # Assign all existing posts to first user
    default_user = User.first
    Post.update_all(user_id: default_user.id)
    
    # Make user_id non-nullable
    change_column_null :posts, :user_id, false
  end

  def down
    remove_reference :posts, :user
  end
end