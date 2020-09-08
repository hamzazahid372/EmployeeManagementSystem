# frozen_string_literal: true

# Attendance model
class Attendance < ApplicationRecord
  belongs_to :company
  belongs_to :user
end
