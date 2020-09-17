class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @user = Current.company.users.build
  end

  def edit
  end

  def create
    success = true
    @user = User.new(sign_up_params)
    binding.pry
    begin
      User.transaction do
        @user.save!
      end
    rescue Exception => e
      success = false
    end
    if success
      flash[:notice] = t 'devise.registraions.sign_up'
    else
      render action: 'new'
    end
    respond_to do |format|
      format.html
    end
  end

  def update
  end

  def destroy
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role_id, :department_id)
  end
end
