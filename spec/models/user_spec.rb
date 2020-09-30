require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @company = create(:company)
    @user = create(:employee, company: @company)
  end

  context 'validation tests for attributes presence' do
    it 'ensures first and last name presence' do
      expect(@user.valid?).to eq true
    end
    it 'ensures first_name absence' do
      @user.first_name = ''
      expect(@user.valid?).to eq false
    end
    it 'ensures last_name absence' do
      @user.last_name = ''
      expect(@user.valid?).to eq false
    end
    it 'ensures role_id absence' do
      @user.role_id = nil
      expect(@user.valid?).to eq false
    end
  end
end
