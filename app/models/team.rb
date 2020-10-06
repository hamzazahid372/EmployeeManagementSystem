# frozen_string_literal: true

# Team model
class Team < ApplicationRecord
  sequenceid :company, :teams
  belongs_to :lead, class_name: 'User'
  belongs_to :created_by, class_name: 'User'
  belongs_to :company
  has_many :users_teams, dependent: :destroy
  has_many :users, through: :users_teams
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :assigned_tasks, class_name: 'Task', as: :assignable, dependent: :nullify
  has_many :tasks_watchers, as: :watcher, dependent: :destroy
  has_many :watching_tasks, through: :tasks_watchers, source: :task
  validates :name, presence: true, length: { minimum: 3 }

  def self.search(q)
    where('name like :q', q: "%#{q}%").map { |t| { id: t.id, name: t.name } }
  end
end
