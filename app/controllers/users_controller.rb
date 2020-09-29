class UsersController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num

  def index
    redirect_to new_user_session_path and return if Current.company_id.nil?

    @users = Current.company.users
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def new
    respond_to do |format|
      format.html
    end
  end

  def edit
    respond_to do |format|
      format.html
    end
  end

  def create
    success = true
    @user = Current.company.users.new(user_params)
    flash[:error] = @user.errors.full_messages.join('<br/>').html_safe unless @user.valid?

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
    @user.assign_attributes(user_params)

    flash[:error] = @user.errors.full_messages.join('<br/>').html_safe unless @user.valid?

    redirect_to edit_user_path(@user) and return unless @user.valid?

    begin
      User.transaction do
        @user.update! user_params
      end
    rescue ActiveRecord::RecordNotSaved
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

  def search
    @users = User.where('first_name like :q or last_name like :q', q: "%#{params[:q]}%")
    @users = @users.map { |u| { id: u.id, name: u.full_name } }
    respond_to do |format|
      format.html
      format.json { render json: @users.to_json }
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role_id, :department_id)
  end
end
