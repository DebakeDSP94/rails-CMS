# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :store_action

  def store_action # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    return unless request.get?

    if request.path != '/users/sign_in' &&
       request.path != '/users/sign_up' &&
       request.path != '/users/password/new' &&
       request.path != '/users/password/edit' &&
       request.path != '/users/confirmation' &&
       request.path != '/users/sign_out' && !request.xhr?
      # don't store ajax calls
      store_location_for(:user, blogs_path)
    end
  end

  def after_sign_out_path_for(_resource_or_scope)
    root_url
  end

  add_flash_types :info, :success, :warning

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[name location employer age link profile]
    )
  end
end
