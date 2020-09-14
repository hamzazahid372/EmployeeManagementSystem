class RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
    @user.build_company
  end

  def create
    success = true
    user = User.new(sign_up_params)
    begin
      User.transaction do
        user.save!
        company = user.company
        company.owner_id = user.id
        company.save!
      end
    rescue Exception
      success = false
    end
    if success
      flash[:notice] = 'Account created succesfully!'
      redirect_to new_user_session_path
    else
      render action: 'new'
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, company_attributes: [:name, :subdomain])
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end
