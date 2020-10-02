class AttachmentsController < ApplicationController
  load_and_authorize_resource :project, find_by: :sequence_num, instance_name: :attachable, only: %i[index create new], if: -> { params[:project_id].present? }
  load_and_authorize_resource :task, find_by: :sequence_num, instance_name: :attachable, only: %i[index create new], if: -> { params[:task_id].present? }
  load_and_authorize_resource :user, find_by: :sequence_num, instance_name: :attachable, only: %i[index create new], if: -> { params[:user_id].present? }
  load_and_authorize_resource :attachment, through: :attachable, only: %i[index create new]
  load_and_authorize_resource :attachment, find_by: :sequence_num, only: %i[destroy]

   # GET /users/:user_id/
  def new
    respond_to do |format|
      format.js
    end
  end

  # POST /users/:user_id/
  def create
    @success = true
    @attachment.user_id = current_user.id
    @attachment.attachment = params[:attachment]
    if @attachment.save
      flash.now[:notice] = t 'attachment.created'
    else
      flash.now[:error] = t 'attachment.not_created'
      @success = false
    end
    respond_to do |format|
      format.js
    end
  end

  #  GET /resource/:resource_id/attachments
  def index
    @attachments = @attachments.page(params[:page]).per_page(6)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # DELETE /attachments/:id
  def destroy
    @attachable = @attachment.attachable
    if @attachment.destroy
      flash[:notice] = t 'attachment.destroyed'
    else
      flash[:notice] = t 'attachment.not_destroyed'
    end
    respond_to do |format|
      format.js
    end
  end
end
