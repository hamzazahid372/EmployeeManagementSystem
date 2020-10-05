require 'rails_helper'

RSpec.describe TimeLogsController, type: :routing do
  describe 'routing' do
    before :all do
      @company = create(:company)
      @project = create(:project, company: @company)
      @user = create(:employee, company: @company)
      @task = create(:task, project: @project, company: @company, created_by: @user)
    end
    it 'should route to #index' do
      expect(get: "/tasks/#{@task.to_param}/time_logs").to route_to(
        controller: 'time_logs',
        action: 'index',
        task_id: @task.to_param
      )
    end
    it 'should route to #new' do
      expect(get: "/tasks/#{@task.to_param}/time_logs/new").to route_to(
        controller: 'time_logs',
        action: 'new',
        task_id: @task.to_param
      )
    end
    it 'should route to #create' do
      expect(post: "/tasks/#{@task.to_param}/time_logs").to route_to(
        controller: 'time_logs',
        action: 'create',
        task_id: @task.to_param
      )
    end
  end
end
