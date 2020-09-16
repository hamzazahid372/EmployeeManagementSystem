class RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
    @user.build_company
    respond_to do |format|
      format.html
    end
  end

  def create
    success = true
    @user = User.new(sign_up_params)
    begin
      User.transaction do
        @user.save!
        company = @user.company
        company.owner_id = @user.id
        company.save!
      end
    rescue Exception => e
      success = false
    end
    if success
      flash[:notice] = I18n.t 'devise.registraions.sign_up'
      redirect_to new_user_session_path
    else
      render action: 'new'
    end
    respond_to do |format|
      format.html
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, company_attributes: [:name, :subdomain])
  end
end
