require 'cancan/matchers'
require 'rails_helper'

describe 'Attachment' do
  before(:all) { @company = create(:company) }
  describe 'abilities' do
    subject(:ability) { Ability.new(user) }
    let(:user) { nil }
    context 'when is an admin' do
      let(:user) { create(:admin, company: @company) }
      it { should be_able_to(:manage, Attachment) }
    end
    context 'when is a member' do
      let(:user) { create(:employee, company: @company) }
      it { should be_able_to(:index, Attachment) }
      it { should be_able_to(:create, Attachment) }
    end
  end
end
