class PostsController < ApplicationController
  def index
    @tag = params[:tag]
    @all_posts = Post.find_recent(:tag => @tag, :include => :tags, :limit => 12)
    @posts = @all_posts[0..1]
    @more_posts = @all_posts[2..12]

    raise(ActiveRecord::RecordNotFound) if @tag && @posts.empty?

    respond_to do |format|
      format.html
      format.atom { render :layout => false }
    end
  end

  def show
    @post = Post.find_by_permalink(*([:year, :month, :day, :slug].collect {|x| params[x] } << {:include => [:approved_comments, :tags]}))
    @comment = Comment.new

    @more_posts = Post.find_recent(:tag => @tag, :include => :tags, :limit => 10)
  end
end
