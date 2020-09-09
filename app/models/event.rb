# frozen_string_literal: true

# Event model
class Event < ApplicationRecord
  belongs_to :company
  belongs_to :created_by, class_name: 'User'
end
