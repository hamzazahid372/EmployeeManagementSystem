require 'rails_helper'

RSpec.describe ReportsController, type: :routing do
describe 'routing' do
    before :all do
    end
    it 'should route to #taks' do
      expect(get: '/reports/tasks').to route_to(
        controller: 'reports',
        action: 'tasks'
      )
    end
    it 'should route to #time_logs' do
      expect(get: '/reports/time_logs').to route_to(
        controller: 'reports',
        action: 'time_logs'
      )
    end
    it 'should route to #task_audits' do
      expect(get: '/reports/task_audits').to route_to(
        controller: 'reports',
        action: 'task_audits'
      )
    end
    it 'should route to #attendance_report' do
      expect(get: '/reports/attendance_report').to route_to(
        controller: 'reports',
        action: 'attendance_report'
      )
    end
  end
end
