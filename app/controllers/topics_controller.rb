# frozen_string_literal: true

class TopicsController < ApplicationController
  before_action :set_sidebar_topics
  layout "blog"

  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    respond_to do |format|
      if @topic.save
        format.html do
          redirect_to blogs_url,
                      success: "Topic was successfully created."
        end
      else
        flash[:danger] = "Topic must have title."
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def show # rubocop:disable Metrics/AbcSize
    @topic = Topic.find(params[:id])

    if logged_in?(:admin) || logged_in?(:editor)
      @blogs = @topic.blogs.recent.page(params[:page]).per(5)
    else
      @topic.blogs.published.recent.page(params[:page]).per(5)
    end
  end

  private

  def set_sidebar_topics
    @side_bar_topics = Topic.with_blogs
  end

  def topic_params
    params.require(:topic).permit(:title, :topic_id)
  end
end
