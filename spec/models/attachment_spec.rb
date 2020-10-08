require 'rails_helper'

RSpec.describe Attachment, type: :model do
  before :each do
    @company = create(:company)
    @user = create(:admin, company: @company)
    @attachment = create(:attachment, company: @company, attachable: @user)
  end

  context 'validation tests for attributes presence' do
    it 'ensures attachment_file_name absence' do
      @attachment.attachment_file_name = ''
      expect(@attachment.valid?).to eq false
    end
    it 'ensures attachment_content_type presence' do
      expect(@attachment.is_image?).to eq true
    end
    it 'ensures attachment_file_size absence' do
      @attachment.attachment_file_size = ''
      expect(@attachment.valid?).to eq true
    end
  end
end
