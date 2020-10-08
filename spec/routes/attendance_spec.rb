require 'rails_helper'

RSpec.describe AttendanceController, type: :routing do
describe 'routing' do
    before :all do
    end
    it 'should route to #log_in' do
      expect(post: '/attendance/log_in').to route_to(
        controller: 'attendance',
        action: 'log_in'
      )
    end
    it 'should route to #log_out' do
      expect(post: '/attendance/log_out').to route_to(
        controller: 'attendance',
        action: 'log_out'
      )
    end
  end
end
