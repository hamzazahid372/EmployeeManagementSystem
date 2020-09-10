# frozen_string_literal: true

# Users Teams model
class UsersTeam < ApplicationRecord
  belongs_to :company
  belongs_to :team
  belongs_to :user
end
