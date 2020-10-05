# frozen_string_literal: true

# Comment model
class Comment < ApplicationRecord
  belongs_to :company
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :attachments, as: :attachable, dependent: :destroy

  validates :content, presence: true
end
