# frozen_string_literal: true

class Blog < ApplicationRecord
  enum status: { draft: 0, published: 1 }

  validates_presence_of :title

  has_rich_text :body
  has_many_attached :images, dependent: :destroy

  has_many :comments, as: :commentable, dependent: :destroy, counter_cache: :commentable_count

  belongs_to :topic, optional: true


  def self.special_blogs
    all
  end

  def self.featured_blogs
    limit(2)
  end

  def self.recent
    order('updated_at DESC')
  end
end
