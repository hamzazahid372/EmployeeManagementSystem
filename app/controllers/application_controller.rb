# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  around_action :scope_current_company

  private

  def current_company
    Company.find_by(subdomain: request.subdomain) if request.subdomain.present?
  end

  helper_method :current_company

  def scope_current_company
    Current.company = current_company unless current_company.nil?
    yield
  ensure
    Current.resets
  end
end
