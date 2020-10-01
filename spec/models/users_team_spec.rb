require 'rails_helper'

RSpec.describe UsersTeam, type: :model do
  before :each do
    @company = create(:company)
    @user = create(:employee, company: @company)
    @team = create(:team, company: @company, created_by: @user, lead: @user)
    @users_team = create(:users_team, team: @team, company: @company, user: @user)
  end

  context 'validation tests for attributes presence' do
    it 'ensures company and user presence' do
      expect(@users_team.valid?).to eq true
    end
    it 'ensures company absence' do
      @users_team.company_id = nil
      expect(@users_team.valid?).to eq false
    end
    it 'ensures user absence' do
      @users_team.user_id = nil
      expect(@users_team.valid?).to eq false
    end
  end
end
