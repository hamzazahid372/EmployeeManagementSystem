class UsersController < ApplicationController
  
  load_and_authorize_resource find_by: :sequence_num

  def index
    redirect_to new_user_session_path and return if Current.company_id.nil?

    @users = User.all
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
    @user = User.new(user_params)
    flash[:error] = @user.errors.full_messages.join('<br/>').html_safe if !@user.valid?

    render new_user_path and return unless @user.valid?

    begin
      User.transaction do
        @user.save!
      end
    rescue ActiveRecord::RecordInvalid
      success = false
    end
    if success
      flash[:success] = t 'users.created_successfully'
      redirect_to user_path(@user) and return
    end
    render new_user_path
  end

  def update
    success = true
    @user.first_name = user_params[:first_name]
    @user.last_name = user_params[:last_name]
    @user.department_id = user_params[:department_id]
    @user.role_id = user_params[:role_id]

    flash[:error] = @user.errors.full_messages.join('<br/>').html_safe unless @user.valid?
  
    redirect_to edit_user_path(@user) and return unless @user.valid?

    begin
      User.transaction do
        @user.update! user_params
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

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role_id, :department_id)
  end
end
