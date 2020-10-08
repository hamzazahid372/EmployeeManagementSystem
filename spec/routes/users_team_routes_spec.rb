require 'rails_helper'

RSpec.describe UsersTeamsController, type: :routing do
  describe 'routing' do
    before :all do
      @company = create(:company)
      @user = create(:employee, company: @company)
      @team = create(:team, company: @company, created_by: @user, lead: @user)
    end
    it 'should route to #index' do
      expect(get: "/teams/#{@team.id}/users_teams").to route_to(
        controller: 'users_teams',
        action: 'index',
        team_id: @team.id.to_s
      )
    end
    it 'should route to #new' do
      expect(get: "/teams/#{@team.id}/users_teams/new").to route_to(
        controller: 'users_teams',
        action: 'new',
        team_id: @team.id.to_s
      )
    end
    it 'should route to #create' do
      expect(post: "/teams/#{@team.id}/users_teams").to route_to(
        controller: 'users_teams',
        action: 'create',
        team_id: @team.id.to_s
      )
    end
  end
end
