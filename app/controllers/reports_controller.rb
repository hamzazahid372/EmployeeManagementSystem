# frozen_string_literal: true

# This class will generate report of different models
class ReportsController < ApplicationController
  def tasks
    @tasks = Task.all
    @tasks = @tasks.page(params[:page]).per_page(PER_PAGE)
  end

  def time_logs
    @time_logs = TimeLog.all
    @time_logs = @time_logs.page(params[:page]).per_page(PER_PAGE)
  end

  def task_audits
    @task = Task.find_by(id: params[:task_id])
    respond_to do |format|
      format.js
    end
  end
end
