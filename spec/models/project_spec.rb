require 'rails_helper'

RSpec.describe Project, type: :model do
  before :all do
    @company = create(:company)
    @project = create(:project, company: @company)
  end

  context 'validation tests for attributes presence' do
    it 'ensures name and status presence' do
      expect(@project.valid?).to eq true
    end
    it 'ensures name absence' do
      @project.name = ''
      expect(@project.valid?).to eq false
    end
    it 'ensures status absence' do
      @project.status = ''
      expect(@project.valid?).to eq false
    end
  end
end
