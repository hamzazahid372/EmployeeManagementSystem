# frozen_string_literal: true

# Holiday model
class Holiday < ApplicationRecord
  belongs_to :company

  validates :day, presence: true
end
