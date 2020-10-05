# frozen_string_literal: true

# Report controller
class ReportsController < ApplicationController
  def tasks
    @tasks = Task.all
    @tasks = @tasks.page(params[:page]).per_page(PER_PAGE)
    respond_to do |format|
      format.html
      format.csv do
        filename = TasksExportService.new(@tasks).to_csv
        set_csv_headers(filename)
        send_file(filename)
      end
    end
  end

  def time_logs
    @time_logs = TimeLog.all
    @time_logs = @time_logs.where(user_id: params[:user_id]) if params[:user_id].present?
    load_resources
    respond_to do |format|
      format.html do
        @time_logs = @time_logs.page(params[:page]).per_page(PER_PAGE)
      end
      format.csv do
        filename = TimeLogsExportService.new(@time_logs).to_csv
        set_csv_headers(filename)
        send_file(filename)
      end
    end
  end

  def task_audits
    @task = Task.find_by(id: params[:task_id])
    respond_to do |format|
      format.js
    end
  end

  def attendance_report
    @attendances = Attendance.all
    @attendances = @attendances.where(user_id: params[:user_id]) if params[:user_id].present?
    load_resources
    respond_to do |format|
      format.html do
        @attendances = @attendances.page(params[:page]).per_page(PER_PAGE)
      end
      format.csv do
        filename = AttendancesExportService.new(@attendances).to_csv
        set_csv_headers(filename)
        send_file(filename)
      end
    end
  end

  private

  def set_csv_headers(filename)
    headers.merge!({
      'Cache-Control'             => 'must-revalidate, post-check=0, pre-check=0',
      'Content-Type'              => 'text/csv',
      'Content-Disposition'       => "attachment; filename=\"#{filename}\"",
      'Content-Transfer-Encoding' => 'binary'
    })
  end

  def load_resources
    @user = User.find_by(id: params[:user_id]) if params[:user_id].present?
  end
end
