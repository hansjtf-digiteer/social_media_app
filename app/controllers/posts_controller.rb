# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
 
  def index
    @featured_posts = Post.where(feature: true)
                         .order(created_at: :desc)
                         .limit(5)
      
    @posts = Post.order(created_at: :desc)
  end
 
  def show
  end
 
  def new
    @post = Post.new(
      active: true,
      publish_date: Time.current
    )
  end
 
  def edit
  end
 
  def create
    @post = Post.new(post_params)
    
    # Auto-feature if less than 5 featured posts exist
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
    @post = Post.find(params[:id])
    
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
 end