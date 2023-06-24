# frozen_string_literal: true

class BlogsController < CommentsController
  before_action :set_blog, only: %i[show edit update destroy toggle_status]
  before_action :set_sidebar_topics,
                except: %i[update create destroy toggle_status]
  layout "blog"
  access all: %i[show index],
         user: {
           except: %i[destroy new create update edit toggle_status]
         },
         admin: :all,
         testing: {
           except: %i[destroy create update]
         }

  def index
    @blogs =
      if logged_in?(:admin) || logged_in?(:testing)
        Blog.recent.with_rich_text_body_and_embeds.page(params[:page]).per(5)
      else
        Blog
          .published
          .recent
          .with_rich_text_body_and_embeds
          .page(params[:page])
          .per(5)
      end
    @page_title = "My Portfolio Blog"
  end

  def show
    if logged_in?(:admin) || logged_in(:editor) || @blog.published?
      @blog = Blog.includes(:comments).find(params[:id])
      @comment = Comment.new
      @page_title = @blog.title
      @seo_keywords = @blog.body
    else
      redirect_to blogs_path,
                  notice: "You are not authorized to access this page."
    end
  end

  def new
    @blog = Blog.new
  end

  def edit
  end

  def create
    @blog = Blog.new(blog_params)
    respond_to do |format|
      if @blog.save
        format.html do
          redirect_to blog_url(@blog), success: "Blog was successfully created."
        end
      else
        flash[:danger] = "Blog must have title, body, and topic."
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html do
          redirect_to blog_url(@blog), success: "Blog was successfully updated."
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to blogs_url, status: :see_other }
    end
  end

  def toggle_status
    if @blog.draft? && logged_in?(:admin)
      @blog.published!
    elsif @blog.published? && logged_in?(:admin)
      @blog.draft!
    end
    redirect_to blogs_url, success: "Post status has been updated."
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :body, :topic_id, :status, images: [])
  end

  def set_sidebar_topics
    @side_bar_topics = Topic.with_blogs
  end
end
