class RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
    @user.build_company
  end

  def create
    if User.create_user_and_company(sign_up_params)
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
