# frozen_string_literal: true

# Task export
class TasksExportService
  HEADERS = [
    I18n.t(:task_title),
    I18n.t(:task_description),
    I18n.t(:task_status),
    I18n.t(:task_priority),
    I18n.t(:task_project_title),
    I18n.t(:task_assignee),
    I18n.t(:task_reviewer),
    I18n.t(:task_start_date),
    I18n.t(:task_end_date),
    I18n.t(:task_due_date)
  ].freeze

  ATTRIBUTES = %w{title description status priority_text project_name assignee_name reviewer_name start_date end_date due_date}.freeze

  attr_reader :tasks

  def initialize(tasks)
    @tasks = tasks
  end

  def to_csv
    path = file_path('csv')
    CSV.open(path, 'wb') do |csv|
      csv << HEADERS
      tasks.each do |task|
        csv << ATTRIBUTES.map { |attr| task.public_send(attr) }
      end
    end
    path
  end

  private

  def file_path(format)
    "#{Rails.root}/system/tasks_reports/#{Current.company.subdomain}-tasks.#{format}"
  end
end
