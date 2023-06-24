# frozen_string_literal: true

module BlogsHelper
  def gravatar_helper(user)
    image_tag "https://gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.downcase)}", width: 60
  end

  def blog_status_color(blog)
    'color: red' if blog.draft?
  end
end
