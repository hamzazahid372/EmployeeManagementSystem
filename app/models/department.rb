# frozen_string_literal: true

# Department model
class Department < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :projects_departments, dependent: :destroy
  has_many :projects, through: :projects_departments
  belongs_to :company
end
