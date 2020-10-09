# frozen_string_literal: true

# Department model
class Department < ApplicationRecord
  sequenceid :company, :departments
  searchkick word_start: [:name, :description]

  has_many :users, dependent: :nullify
  has_many :projects_departments, dependent: :destroy
  has_many :projects, through: :projects_departments
  belongs_to :company
  validates :name, presence: true, length: { minimum: 3 }

  def can_destroy?
    users_count = users.count
    projects_count = projects.count
    errors.add(:base, I18n.t('department.dependent_users', users_count: users_count)) if users_count.positive?

    errors.add(:base, I18n.t('department.dependent_projects', projects_count: projects_count)) if projects_count.positive?

    errors.blank?
  end
end
