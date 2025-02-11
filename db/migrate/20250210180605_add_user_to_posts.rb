
class AddUserToPosts < ActiveRecord::Migration[7.0]
  def up

    add_reference :posts, :user, null: true, foreign_key: true
    
    User.create!(
      email: 'admin@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
    
   
    default_user = User.first
    Post.update_all(user_id: default_user.id)
    
   
    change_column_null :posts, :user_id, false
  end

  def down
    remove_reference :posts, :user
  end
end