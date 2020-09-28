# frozen_string_literal: true

# TimeLog model
class TimeLog < ApplicationRecord
  belongs_to :task
  belongs_to :company
  belongs_to :user

  ROLES = {
    'Design' => 1,
    'Development' => 2,
    'Testing' => 3
  }.freeze
end
