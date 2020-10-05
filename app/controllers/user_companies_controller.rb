# frozen_string_literal: true

# User Company Controller
class UserCompaniesController < ApplicationController
  def find
    if request.subdomain.present?
      redirect_to new_user_session_url and return
    end
    respond_to do |format|
      format.html
    end
  end

  def search_by_email
    success = true
    begin
      user = User.unscope(where: :company_id).find_by! email: params[:email]
      company = Company.find_by! id: user.company_id
    rescue ActiveRecord::RecordNotFound
      success = false
    end
    if success
      redirect_to new_user_session_url(subdomain: company.subdomain) and return
    else
      if params[:email].blank?
        flash.now[:error] = t 'failure.email_empty'
      else
        flash.now[:error] = t 'failure.email_not_recognized'
      end
      render action: 'find'
    end
  end
end
