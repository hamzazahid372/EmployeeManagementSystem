# frozen_string_literal: true

# User Controller
class UsersController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num

  # GET /users
  def index
    redirect_to new_user_session_path and return if Current.company_id.nil?

    add_breadcrumb 'Users', users_path
    @users = Current.company.users
    respond_to do |format|
      format.html
    end
  end

  # GET /users/:id
  def show
    add_breadcrumb 'Users', users_path
    add_breadcrumb @user.full_name, user_path(@user)

    respond_to do |format|
      format.html
    end
  end

  # GET /users/new
  def new
    add_breadcrumb 'Users', users_path
    add_breadcrumb 'Create User', new_user_path
    @departments = Current.company.departments
    respond_to do |format|
      format.html
    end
  end

  # GET /users/:id/edit
  def edit
    add_breadcrumb 'Users', users_path
    add_breadcrumb @user.full_name, user_path(@user)
    add_breadcrumb 'Update', edit_user_path(@user)

    @departments = Current.company.departments
    respond_to do |format|
      format.html
    end
  end

  # POST /users
  def create
    # @departments = Current.company.departments
    rand_password = Devise.friendly_token.first(8)
    @user.password = rand_password
    @user.password_confirmation = rand_password
    @user.sys_generated_password = rand_password
    if @user.save
      flash[:success] = t 'users.created_successfully'
      redirect_to user_path(@user) and return
    else
      flash[:error] = @user.errors.full_messages
    end
    render new_user_path
  end

  # PUT /users/:id
  def update
    @user.assign_attributes(user_params)
    redirect_to edit_user_path(@user) and return unless @user.valid?

    if @user.update user_params
      flash[:notice] = t 'users.account_updated'
    else
      # flash[:notice] = t 'users.account_not_updated'
      # flash[:error] = @user.errors.full_messages.join('<br/>').html_safe
      flash[:error] = @user.errors.full_messages
    end
    redirect_to edit_user_path(@user)
  end

  # DELETE /users/:id
  def destroy
    if @user.can_destroy?
      if @user.destroy
        flash[:notice] = t('users.account_deleted')
      else
        flash[:error] = @user.errors.full_messages
      end
    else
      flash[:error] = @user.errors.full_messages
    end

    respond_to do |format|
      format.html do
        if flash[:error].blank?
          redirect_to users_path
        else
          redirect_to @user
        end
      end
    end
  end

  # GET /users/:id/change_password
  def change_password
    respond_to do |format|
      format.html
    end
  end

  def search
    @users = @users.search(params[:q], params.slice(:only_admins, :project_id))
    @users = @users.map { |u| { id: u.id, name: u.full_name } }
    respond_to do |format|
      format.json { render json: @users.to_json }
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role_id, :department_id)
  end
end
