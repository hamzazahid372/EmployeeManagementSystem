class AttachmentsController < ApplicationController
  load_and_authorize_resource :project, find_by: :sequence_num, instance_name: :attachable, only: %i[index create], if: -> { params[:project_id].present? }
  load_and_authorize_resource :task, find_by: :sequence_num, instance_name: :attachable, only: %i[index create], if: -> { params[:task_id].present? }
  load_and_authorize_resource :user, find_by: :sequence_num, instance_name: :attachable, only: %i[index create], if: -> { params[:user_id].present? }
  load_and_authorize_resource :attachment, through: :attachable, only: %i[index create]
  load_and_authorize_resource :attachment, only: %i[edit update show destroy]
  binding.pry
  def edit
  end

  def show
    @attachment = Attachment.find(params[:id])
    respond_to do |format|
      format.html # index.js.erb
    end
  end

  def create
    success = true
    @attachment.user_id = current_user.id
    @attachment.attachment = params[:attachment]
    if @attachment.save
      flash.now[:notice] = 'Attachment uploaded'
    else
      flash.now[:error] = 'Attachment not uploaded'
      success = false
    end
    respond_to do |format|
      format.js
    end
  end

  def index
    binding.pry
    @attachment = @attachable.attachments.build
    respond_to do |format|
      format.html
      format.js # index.js.erb
    end
  end

  def display
    @attachment = @attachable.attachments.build
    @attachments = Attachment.all
  end
  # private

  # def attachment_params
  #   params.require(:attachment).permit(:attachment)
  # end
end
