# frozen_string_literal: true

# Department model
class Department < ApplicationRecord
  sequenceid :company, :departments
  has_many :users, dependent: :nullify
  has_many :projects_departments, dependent: :destroy
  has_many :projects, through: :projects_departments
  belongs_to :company
  validates :name, presence: true, length: { minimum: 3 }
end
