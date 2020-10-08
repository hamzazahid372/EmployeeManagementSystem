require 'rails_helper'

RSpec.describe Attendance, type: :model do
  before :each do
    @company = create(:company)
    @user = create(:admin, company: @company)
    @attendance = create(:attendance, company: @company, user: @user)
  end

  context 'validation tests for attributes presence' do
    it 'ensures date presence' do
      @attendance.date = nil
      expect(@attendance.valid?).to eq false
    end
  end
end
