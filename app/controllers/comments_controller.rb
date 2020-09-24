class CommentsController < ApplicationController
  def index
    @user = current_user
    @comments = Comment.where user_id: current_user.id
  end

  def show
  end

  def new
    binding.pry
  end

  def edit
  end

  def create
    binding.pry
  end

  def update
  end

  def destroy
  end
end
