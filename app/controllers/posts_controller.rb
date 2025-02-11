# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :verify_post_owner, only: [:edit, :update, :destroy]

  def index
    @featured_posts = Post.featured.active
                         .order(created_at: :desc)
                         .limit(5)
    
    @posts = Post.active.order(created_at: :desc)
  end

  def show
  end

  def new
    @post = current_user.posts.build(
      active: true,
      publish_date: Time.current
    )
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    
    if Post.featured.count < 5
      @post.feature = true
    end

    if @post.save
      redirect_to root_path, notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: 'Post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: 'Post was successfully deleted.'
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :feature, :active, :publish_date)
    end

    def verify_post_owner
      unless @post.user == current_user || current_user.admin?
        redirect_to root_path, alert: 'You are not authorized to perform this action.'
      end
    end
end