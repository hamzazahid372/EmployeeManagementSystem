# frozen_string_literal: true

# Attachment Model
class Attachment < ApplicationRecord
  sequenceid :company, :attachments
  belongs_to :company
  belongs_to :attachable, polymorphic: true
  has_attached_file :attachment, styles: { thumbnail: '60x60#' }
  validates_attachment_content_type :attachment, content_type: ["image/jpeg", "image/gif", "image/png", 'application/pdf']
  # do_not_validate_attachment_file_type :attachment
end

