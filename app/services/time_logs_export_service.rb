# frozen_string_literal: true

# Time Log export
class TimeLogsExportService
  HEADERS = [
    I18n.t(:time_logs_user),
    I18n.t(:time_logs_hours),
    I18n.t(:time_logs_activity),
    I18n.t(:time_logs_comment)
  ].freeze

  ATTRIBUTES = %w{user_name hours activity_text comment}.freeze

  attr_reader :time_logs

  def initialize(time_logs)
    @time_logs = time_logs
  end

  def to_csv
    path = file_path('csv')
    CSV.open(path, 'wb') do |csv|
      csv << HEADERS
      time_logs.each do |time_log|
        csv << ATTRIBUTES.map { |attr| time_log.public_send(attr) }
      end
    end
    path
  end

  private

  def file_path(format)
    "#{Rails.root}/system/time_logs_reports/#{Current.company.subdomain}-time_logs.#{format}"
  end
end
