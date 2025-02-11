class Admin::PostsController < Admin::BaseController
  def index
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: 'Post updated'
    else
      redirect_to admin_posts_path, alert: 'Update failed'
    end
  end

  private

  def post_params
    params.require(:post).permit(:feature, :active)
  end
end