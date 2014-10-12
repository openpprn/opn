class PostsController < ApplicationController
  authorize_actions_for Post
  before_action :authenticate_user!

  before_action :set_post

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_post @post
    end
  end

  def update
    if @post.update(post_params)
      redirect_post @post
    end
  end

  def edit
  end

  def new
    @post = Post.new(post_type: params[:post_type])
  end

  def destroy
    @post.destroy

    redirect_post @post

  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :post_type, :state, :author, :introduction, tags: [])
  end

  def set_post
    @post = Post.find_by_id(params[:id])
  end

  def redirect_post(post)
    if post.is_notification?
      redirect_to admin_notifications_path
    else
      redirect_to admin_blog_path
    end
  end
end