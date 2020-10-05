# frozen_string_literal: true

# Attendance model
class Attendance < ApplicationRecord
  belongs_to :company
  belongs_to :user

  def user_name
    user&.full_name
  end
end
