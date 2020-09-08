# frozen_string_literal: true

# Attachment model
class Attachment < ApplicationRecord
  belongs_to :comapny
  belongs_to :attachable, polymorphic: true
end
