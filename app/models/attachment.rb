# frozen_string_literal: true

# Attachment Model
class Attachment < ApplicationRecord
  sequenceid :company, :attachments
  belongs_to :company
  belongs_to :attachable, polymorphic: true
  has_attached_file :attachment, styles: lambda { |a| a.instance.is_image? ? { thumbnail: '320x240!' } : {} }
  validates_attachment :attachment, presence: true, content_type: { content_type: %w(image/jpeg image/jpg image/png image/gif application/pdf application/msword application/vnd.ms-excel application/vnd.openxmlformats-officedocument.wordprocessingml.document application/vnd.openxmlformats-officedocument.spreadsheetml.sheet text/plain text/css application/js text/plain text/x-json application/json application/javascript application/x-javascript text/javascript text/x-javascript text/x-json
   text/html application/xhtml application/xml text/xml text/js) }, size: { less_than: 20.megabyte }

  def is_image?
    attachment_content_type.to_s.start_with?('image/')
  end
end
