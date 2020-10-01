require 'cancan/matchers'
require 'rails_helper'

describe 'UsersTeam' do
  before(:all) { @company = create(:company) }
  describe 'abilities' do
    subject(:ability) { Ability.new(user) }
    let(:user) { nil }
    context 'when is an admin' do
      let(:user) { create(:admin, company: @company) }
      it { should be_able_to(:manage, UsersTeam) }
    end
    context 'when is a member' do
      let(:user) { create(:employee, company: @company) }
      it { should be_able_to(:index, UsersTeam) }
      it { should be_able_to(:show, UsersTeam) }
      it { should_not be_able_to(:create, UsersTeam) }
      it { should_not be_able_to(:edit, UsersTeam) }
      it { should_not be_able_to(:update, UsersTeam) }
      it { should_not be_able_to(:destroy, UsersTeam) }
    end
  end
end
