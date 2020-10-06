# frozen_string_literal: true

# Registration Controller
class RegistrationsController < Devise::RegistrationsController
  # GET /user/sign_up
  def new
    redirect_to new_user_registration_url(subdomain: '') and return if Current.company.present?

    @user = User.new
    @user.build_company
    respond_to do |format|
      format.html
    end
  end

  # POST /user
  def create
    success = true
    @user = User.new(sign_up_params)
    @user.role_id = User::ROLES['Administrator']
    begin
      User.transaction do
        @user.save!
        company = @user.company
        company.owner_id = @user.id
        company.save!
      end
    rescue ActiveRecord::RecordNotSaved, ActiveRecord::RecordInvalid
      success = false
    end
    if success
      flash[:notice] = t 'devise.registraions.signed_up'
      redirect_to new_user_session_url(subdomain: @user.company.subdomain) and return
    else
      render action: 'new'
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, company_attributes: [:name, :subdomain])
  end
end
