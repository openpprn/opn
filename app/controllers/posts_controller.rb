class PostsController < ApplicationController
  authorize_actions_for Post

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to :back
    end
  end

  def update
    if @post.update(post_params)

    end
  end

  def edit
  end

  def new
    @post = Post.new
  end

  def destroy
    @post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :post_type, :state)
  end

  def set_post
    @post = Post.find_by_id(params[:id])
  end
end