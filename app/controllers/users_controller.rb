class UsersController < ApplicationController
  
  load_and_authorize_resource find_by: :sequence_num

  def index
    redirect_to new_user_session_path and return if Current.company_id.nil?

    @users = User.all
  end

  def show
    @user = User.find_by(sequence_num: params[:id])
  end

  def new
    @user = Current.company.users.build
  end

  def edit
    @user = User.find_by(sequence_num: params[:id])
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
        redirect_to user_path(@user.id)
      end
    else
      flash[:error] = t 'users.email_in_use'
      redirect_to new_user_path
    end
  end

  def update
    success = true
    begin
      User.transaction do
        @user.update! sign_up_params
      end
    rescue Exception
      success = false
    end
    if success
      flash[:notice] = t 'users.account_updated'
    else
      flash[:notice] = t 'users.account_not_updated'
    end
    redirect_to edit_user_path(@user)
  end

  def destroy
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
