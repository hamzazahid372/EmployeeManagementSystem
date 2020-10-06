class Holiday < ApplicationRecord
  belongs_to :company

  validates :day, presence: true
end
