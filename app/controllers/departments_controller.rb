class DepartmentsController < ApplicationController
  def new
    @department = Department.new
    respond_to do |format|
      format.html
    end
  end

  def edit
    respond_to do |format|
      format.html
    end
  end

  def index
    @departments = Department.all
  end

  def show
    respond_to do |format|
      format.html
    end
  end
end
