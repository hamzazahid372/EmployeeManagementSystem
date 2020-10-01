# frozen_string_literal: true

# projectsusers model
class ProjectsUser < ApplicationRecord
  belongs_to :company
  belongs_to :project
  belongs_to :user
  validates :user_id, presence: true
  validates :user_id, uniqueness: { scope: :project_id }
end
