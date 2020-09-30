class AttachmentsController < ApplicationController
  load_and_authorize_resource :project, find_by: :sequence_num, instance_name: :attachable, only: %i[index create new], if: -> { params[:project_id].present? }
  load_and_authorize_resource :task, find_by: :sequence_num, instance_name: :attachable, only: %i[index create new], if: -> { params[:task_id].present? }
  load_and_authorize_resource :user, find_by: :sequence_num, instance_name: :attachable, only: %i[index create new], if: -> { params[:user_id].present? }
  load_and_authorize_resource :attachment, through: :attachable, only: %i[index create new]
  load_and_authorize_resource :attachment, only: %i[edit update show destroy]

  def new
    respond_to do |format|
      format.js # new.js.erb
    end
  end

  def show
    @attachment = Attachment.find(params[:id])
    respond_to do |format|
      format.html # index.js.erb
    end
  end

  def create
    @success = true
    @attachment.user_id = current_user.id
    @attachment.attachment = params[:attachment]
    if @attachment.save
      flash[:notice] = t 'attachment.created'
    else
      flash[:error] = t 'attachment.not_created'
      @success = false
    end
    respond_to do |format|
      format.js
    end
  end

  def index
    @attachments = @attachments.page(params[:page]).per_page(PER_PAGE)
    respond_to do |format|
      format.html
      format.js # index.js.erb
    end
  end
end
