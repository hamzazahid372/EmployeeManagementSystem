# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  around_action :scope_current_company
  before_action :authenticate_user!
  before_action :set_current_user

  private

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = t 'cancan.access_denied'
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js { render js: "alert('Access Denied');" }
    end
  end

  def after_sign_out_path_for(resource)
    new_user_session_url
  end

  def after_sign_in_path_for(resource)
    root_url
  end

  def current_company
    Company.find_by!(subdomain: request.subdomain)
  end

  helper_method :current_company

  def scope_current_company
    Current.company = current_company if request.subdomain.present?
    yield
  ensure
    Current.reset
  end

  def set_current_user
    Current.user = current_user
  end
end
