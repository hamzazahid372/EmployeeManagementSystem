require 'cancan/matchers'
require 'rails_helper'

describe 'TimeLog' do
  before(:all) { @company = create(:company) }
  describe 'abilities' do
    subject(:ability) { Ability.new(user) }
    let(:user) { nil }
    context 'when is an admin' do
      let(:user) { create(:admin, company: @company) }
      it { should be_able_to(:manage, TimeLog) }
    end
    context 'when is a member' do
      let(:user) { create(:employee, company: @company) }
      it { should_not be_able_to(:index, TimeLog) }
      it { should_not be_able_to(:show, TimeLog) }
      it { should be_able_to(:create, TimeLog) }
      it { should_not be_able_to(:edit, TimeLog) }
      it { should_not be_able_to(:update, TimeLog) }
      it { should_not be_able_to(:destroy, TimeLog) }
    end
  end
end
