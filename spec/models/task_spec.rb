require 'rails_helper'

RSpec.describe Task, type: :model do
  before :all do
    @company = create(:company)
    @project = create(:project, company: @company)
    @user = create(:employee, company: @company)
    @task = create(:task, project: @project, company: @company, created_by: @user)
  end

  context 'validation tests for attributes presence' do
    it 'ensures title, status, priority, company, project, and user presence' do
      expect(@task.valid?).to eq true
    end
    it 'ensures title absence' do
      @task.title = ''
      expect(@task.valid?).to eq false
    end
    it 'ensures status absence' do
      @task.status = ''
      expect(@task.valid?).to eq false
    end
    it 'ensures priority absence' do
      @task.priority = nil
      expect(@task.valid?).to eq false
    end
    it 'ensures company absence' do
      @task.company_id = nil
      expect(@task.valid?).to eq false
    end
    it 'ensures project absence' do
      @task.project_id = nil
      expect(@task.valid?).to eq false
    end
    it 'ensures user absence' do
      @task.created_by_id = nil
      expect(@task.valid?).to eq false
    end
  end
end
