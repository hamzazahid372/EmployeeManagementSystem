# frozen_string_literal: true

# projectsusers model
class ProjectsUser < ApplicationRecord
  belongs_to :company
  belongs_to :project
  belongs_to :user
end
