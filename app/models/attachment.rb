# frozen_string_literal: true

# Attachment Model
class Attachment < ApplicationRecord
  belongs_to :company
  belongs_to :attachable, polymorphic: true
end
