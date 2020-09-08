# frozen_string_literal: true

# Event model
class Event < ApplicationRecord
  belongs_to :company
  belongs_to :user, foreign_key: 'craeted_by_id'
end
