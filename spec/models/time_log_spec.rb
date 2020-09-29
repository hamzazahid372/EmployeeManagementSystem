require 'rails_helper'

RSpec.describe TimeLog, type: :model do
  before :each do
    @company = create(:company)
    @project = create(:project, company: @company)
    @user = create(:employee, company: @company)
    @task = create(:task, project: @project, company: @company, created_by: @user)
    @time_log = create(:time_log, task: @task, company: @company, user: @user)
  end

  context 'validation tests for attributes presence' do
    it 'ensures company and user presence' do
      expect(@time_log.valid?).to eq true
    end
    it 'ensures company absence' do
      @time_log.company_id = nil
      expect(@time_log.valid?).to eq false
    end
    it 'ensures user absence' do
      @time_log.user_id = nil
      expect(@time_log.valid?).to eq false
    end
  end
end
