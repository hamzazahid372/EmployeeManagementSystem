class UserCompaniesController < ApplicationController
  def find
    respond_to do |format|
      format.html
    end
  end

  def search_by_email
    success = true
    begin
      user = User.unscope(where: :company_id).find_by! email: params[:email]
      company = Company.find_by! id: user.company_id
    rescue Exception => e
      success = false
    end
    if success
      redirect_to new_user_session_url(subdomain: company.subdomain)
    else
      render action: 'new'
    end
  end
end
