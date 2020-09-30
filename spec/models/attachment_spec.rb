require 'rails_helper'

RSpec.describe Project, type: :model do
  before :all do
    @company = create(:company)
    @attachment = create(:attachment, company: @company)
  end

  context 'validation tests for attributes presence' do
    it 'ensures attachment_file_name absence' do
      @attachment.attachment_file_name = ''
      expect(@attachment.valid?).to eq true
    end
    it 'ensures attachment_content_type absence' do
      @attachment.attachment_file_size = ''
      expect(@attachment.valid?).to eq true
    end
    it 'ensures attachment_file_size absence' do
      @attachment.attachment_file_size = ''
      expect(@attachment.valid?).to eq true
    end
  end
end