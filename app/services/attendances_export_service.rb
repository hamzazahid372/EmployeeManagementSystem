# frozen_string_literal: true

# Time Log export
class AttendancesExportService
  HEADERS = [
    I18n.t(:attendance_user),
    I18n.t(:attendance_login_time),
    I18n.t(:attendance_logout_time),
    I18n.t(:attendance_date)
  ].freeze

  ATTRIBUTES = %w{user_name login_time logout_time date}.freeze

  attr_reader :attendances

  def initialize(attendances)
    @attendances = attendances
  end

  def to_csv
    path = file_path('csv')
    CSV.open(path, 'wb') do |csv|
      csv << HEADERS
      attendances.each do |attendance|
        csv << ATTRIBUTES.map { |attr| attendance.public_send(attr) }
      end
    end
    path
  end

  private

  def file_path(format)
    "#{Rails.root}/system/attendances_reports/#{Current.company.subdomain}-attendances.#{format}"
  end
end
