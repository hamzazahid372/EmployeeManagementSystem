# frozen_string_literal: true

# User Company Controller
class UserCompaniesController < ApplicationController
  skip_before_action :authenticate_user!

  # GET /user_companies/find
  def find
    if request.subdomain.present?
      redirect_to new_user_session_url and return
    end
    respond_to do |format|
      format.html
    end
  end

  # POST /user_companies/find
  def search_by_email
    success = true
    @user = User.unscope(where: :company_id).where! email: params[:email]
    if @user.present?
      if @user.length == 1
        redirect_to new_user_session_url(subdomain: @user.first.company.subdomain) and return
      else
        redirect_to user_companies_index_path(email: params[:email])

      end
    else
      flash.now[:error] = t 'failure.email_not_recognized'
      render action: 'find'
    end
  end

  # GET /user_companies/index
  def index
    if params[:email].present?
      @user = User.unscope(where: :company_id).where! email: params[:email]
    else
      redirect_to user_companies_find_path
    end
  end
end
