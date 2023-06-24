# frozen_string_literal: true

class Topic < ApplicationRecord
  has_many :blogs

  validates_presence_of :title

  def self.with_blogs
    includes(:blogs).where.not(blogs: { id: nil })
  end
end
