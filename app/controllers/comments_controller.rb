# frozen_string_literal: true

# Comment Controller
class CommentsController < ApplicationController
  load_and_authorize_resource :project, find_by: :sequence_num, instance_name: :commentable, only: %i[index create], if: -> { params[:project_id].present? }
  load_and_authorize_resource :team, find_by: :sequence_num, instance_name: :commentable, only: %i[index create], if: -> { params[:team_id].present? }
  load_and_authorize_resource :task, find_by: :sequence_num, instance_name: :commentable, only: %i[index create], if: -> { params[:task_id].present? }
  load_and_authorize_resource :user, find_by: :sequence_num, instance_name: :commentable, only: %i[index create], if: -> { params[:user_id].present? }
  load_and_authorize_resource :comment, through: :commentable, only: %i[index create]
  load_and_authorize_resource :comment, only: %i[edit update show destroy]

  # GET /comments/:id
  def show
    respond_to do |format|
      format.js
    end
  end

  #  GET /teams/:team_id/comments
  def index
    @comment = @commentable.comments.build
    respond_to do |format|
      format.js
    end
  end

  # GET /comments/:id/edit
  def edit
    respond_to do |format|
      format.js
    end
  end

  # POST /teams/:team_id/comments
  def create
    @comment.user_id = current_user.id
    if @comment.save
      flash.now[:notice] = t 'comments.created'
    else
      flash.now[:error] = @comment.errors.full_messages
    end
    respond_to do |format|
      format.js
    end
  end

  # PATCH /comments/:id
  def update
    if @comment.update(comment_params)
      flash.now[:notice] = t 'comments.updated'
    else
      flash.now[:error] = t 'comments.not_updated'
    end

    respond_to do |format|
      format.js
    end
  end

  # DELETE /comments/:id
  def destroy
    if @comment.destroy
      flash.now[:notice] = t 'comments.destroyed'
    else
      flash.now[:error] = t 'comments.not_destroyed'
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
