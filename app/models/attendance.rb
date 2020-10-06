# frozen_string_literal: true

# Attendance model
class Attendance < ApplicationRecord
  STATUS = {
    'Present' => 1,
    'Absent' => 2,
    'Off day' => 3,
    'Holiday' => 4,
    'Leave' => 5
  }.freeze

  belongs_to :company
  belongs_to :user

  validates :date, presence: true

  before_save :set_status

  def user_name
    user&.full_name
  end

  def off_day?
    status == STATUS['Off day']
  end

  private

  def set_status
    if login_time.present?
      self.status = STATUS['Present']
    elsif company.off_day?(date)
      self.status = STATUS['Off day']
    elsif company.holiday?(date)
      self.status = STATUS['Holiday']
    else
      self.status = STATUS['Absent']
    end
  end
end
