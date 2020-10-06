# frozen_string_literal: true

# Working model
class WorkingDay < ApplicationRecord
  DAY_NAMES = {
    0 => 'Sun',
    1 => 'Mon',
    2 => 'Tue',
    3 => 'Wed',
    4 => 'Thu',
    5 => 'Fri',
    6 => 'Sat'
  }.freeze
  belongs_to :company
  validates :from, presence: true
  validates :to, presence: true
end
