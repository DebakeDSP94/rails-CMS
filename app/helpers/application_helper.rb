module ApplicationHelper
  def login_helper(_style = '') # rubocop:disable Metrics/MethodLength
    if !user_signed_in?
      link_to('Register', new_user_registration_path, class: 'navbar-item') +
        ' '.html_safe +
        link_to('Login', new_user_session_path, class: 'navbar-item')
    else
      link_to(
        'Logout',
        destroy_user_session_path,
        data: {
          turbo_method: :delete
        },
        class: 'navbar-item'
      )
    end
  end

  def active?(path)
    'active' if current_page?(path)
  end

  def flash_class(level) # rubocop:disable Metrics/MethodLength
    case level.to_sym
    when :notice
      'notification is-primary'
    when :success
      'notification is-success'
    when :alert
      'notification is-warning'
    when :error
      'notification is-danger'
    else
      'notification is-info'
    end
  end

  def copyright_generator
    WilsonViewTool::Renderer.copyright('Stuart Wilson', 'All rights reserved')
  end

  def profile_helper(user)
    if user.profile.file.nil?
      gravatar_helper(user)
    else
      image_tag(
        user.profile.to_s,
        width: 60,
        height: 60,
        style: 'border-radius: 50%'
      ).html_safe
    end
  end

  def gravatar_helper(user)
    image_tag(
      "https://gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.downcase)}",
      width: 60,
      height: 60,
      style: 'border-radius: 50%;'
    )
  end

  def nav_items
    [
      {
        url: root_path,
        title: 'Home'
      },
      {
        url: blogs_path,
        title: 'Blog'
      }
    ]
  end

  def nav_helper(style = '', tag_type = '')
    nav_links = ''

    nav_items.each do |item|
      nav_links << "<#{tag_type}><a href='#{item[:url]}' class='#{style} #{active? item[:url]}'>#{item[:title]}</a></#{tag_type} %>"
    end
    nav_links.html_safe
  end

  def authorized_to
    logged_in?(:admin) || logged_in?(:editor)
  end

  def top_authorized
    logged_in(:admin)
  end
end
