# frozen_string_literal: true

# TimeLog model
class TimeLog < ApplicationRecord
  belongs_to :task
  belongs_to :company
  belongs_to :user

  ACTIVITIES = {
    'Design' => 1,
    'Development' => 2,
    'Testing' => 3
  }.freeze

  ACTIVITIES_REVERSE = {
    1 => 'Design',
    2 => 'Development',
    3 => 'Testing'
  }.freeze
  validates_length_of :hours, minimum: 0, maximum: 999
  validates :hours, numericality: { only_integer: true }
  validates :activity_id, presence: true
  validates :task_id, presence: true
  def user_name
    user&.full_name
  end

  def task_name
    task&.title
  end

  def activity_text
    ACTIVITIES_REVERSE[activity_id]
  end
end
