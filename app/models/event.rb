# frozen_string_literal: true

# Event model
class Event < ApplicationRecord
  sequenceid :company, :events
  belongs_to :company
  belongs_to :created_by, class_name: 'User'
  validates :title, presence: true, length: { minimum: 3 }
  validates :start, presence: true
end
