# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  around_action :scope_current_company

  private

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = t 'cancan.access_denied'
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js { render js: "alert('Access Denied');" }
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404", status: :not_found }
      format.js { render js: "alert('Page not found');" }
    end
  end

  def after_sign_out_path_for(resource)
    new_user_session_url
  end

  def current_company
    @current_company ||= Company.find_by!(subdomain: request.subdomain)
  end

  helper_method :current_company

  def scope_current_company
    Current.company = current_company if request.subdomain.present?
    yield
  ensure
    Current.reset
  end
end
