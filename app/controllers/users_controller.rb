class UsersController < ApplicationController
  def index
    @users = User.unscope(where: :company_id).all
  end

  def show
    @user = User.unscope(where: :company_id).find params[:id]
  end

  def new
    @user = Current.company.users.build
  end

  def edit
    @user = User.unscope(where: :company_id).find_by id: params[:id]
  end

  def create
    success = true
    @user = User.unscope(where: :company_id).find_by email: sign_up_params[:email]
    if @user.nil?
      @user = User.new(sign_up_params)
      begin
        User.transaction do
          @user.save!
        end
      rescue ActiveRecord::RecordInvalid
        success = false
      end
      if success
        flash[:success] = t 'users.created_successfully'
        redirect_to @user
      end
    else
      flash[:error] = t 'users.email_in_use'
      redirect_to new_user_path
    end
  end

  def update
    @user = User.unscope(where: :company_id).find params[:id]
    @user.update sign_up_params
    flash[:notice] = t 'users.account_updated'
    redirect_to edit_user_path(@user)
  end

  def destroy
    @user = User.unscope(where: :company_id).find params[:id]
    success = true
    begin
      User.transaction do
        @user.destroy!
      end
    rescue ActiveRecord::RecordNotDestroyed
      success = false
    end
    if success
      flash[:success] = t 'users.account_deleted'
      redirect_to users_path, method: :get
    else
      flash[:error] = t 'users.account_not_deleted'
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role_id, :department_id)
  end
end
