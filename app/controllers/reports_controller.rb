# frozen_string_literal: true

# Report controller
class ReportsController < ApplicationController
  load_and_authorize_resource :task, only: %i[task_audits], find_by: :sequence_num

  # GET /reports/tasks
  def tasks
    add_breadcrumb 'Tasks Report', reports_tasks_path
    @tasks = Task.accessible_by(current_ability)
    @tasks = @tasks.where(project_id: params[:project_id]) if params[:project_id].present?
    load_resources
    respond_to do |format|
      format.html do
         @tasks = @tasks.page(params[:page]).per_page(PER_PAGE)
       end
      format.csv do
        filename = TasksExportService.new(@tasks).to_csv
        set_csv_headers(filename)
        send_file(filename)
      end
    end
  end

  # GET /reports/time_logs
  def time_logs
    add_breadcrumb 'Time Logs', reports_time_logs_path
    @time_logs = TimeLog.accessible_by(current_ability)
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

  # /reports/task_audits
  def task_audits
    respond_to do |format|
      format.js
    end
  end

  # GET /reports/attendance_report
  def attendance_report
    add_breadcrumb 'Attendance Report', reports_attendance_report_path
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
    @project = Project.find_by(id: params[:project_id]) if params[:project_id].present?
  end
end
