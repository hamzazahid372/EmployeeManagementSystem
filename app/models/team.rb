# frozen_string_literal: true

# Team model
class Team < ApplicationRecord
  belongs_to :user, foreign_key: 'lead_id'
  belongs_to :company
  has_many :users_team
  has_many :users, through: :users_team
  has_many :tasks, as: :watcher
end
