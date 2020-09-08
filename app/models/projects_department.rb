# frozen_string_literal: true

# ProjectsDepartment model
class ProjectsDepartment < ApplicationRecord
  belongs_to :company
  belongs_to :project
  belongs_to :department
end
