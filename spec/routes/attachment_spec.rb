require 'rails_helper'

RSpec.describe AttachmentsController, type: :routing do
  describe 'routing' do
    before :all do
      @company = create(:company)
      @project = create(:project, company: @company)
      @user = create(:employee, company: @company)
      @task = create(:task, project: @project, company: @company, created_by: @user)
    end
    it 'should route to #index for task' do
      expect(get: "/tasks/#{@task.to_param}/attachments").to route_to(
        controller: 'attachments',
        action: 'index',
        task_id: @task.to_param
      )
    end
    it 'should route to #index for project' do
      expect(get: "/projects/#{@project.to_param}/attachments").to route_to(
        controller: 'attachments',
        action: 'index',
        project_id: @project.to_param
      )
    end
    it 'should route to #index for User' do
      expect(get: "/users/#{@user.to_param}/attachments").to route_to(
        controller: 'attachments',
        action: 'index',
        user_id: @user.to_param
      )
    end
    it 'should route to #new for task' do
      expect(get: "/tasks/#{@task.to_param}/attachments/new").to route_to(
        controller: 'attachments',
        action: 'new',
        task_id: @task.to_param
      )
    end
    it 'should route to #new for project' do
      expect(get: "/projects/#{@project.to_param}/attachments/new").to route_to(
        controller: 'attachments',
        action: 'new',
        project_id: @project.to_param
      )
    end
    it 'should route to #new for user' do
      expect(get: "/users/#{@user.to_param}/attachments/new").to route_to(
        controller: 'attachments',
        action: 'new',
        user_id: @user.to_param
      )
    end
    it 'should route to #create for task' do
      expect(post: "/tasks/#{@task.to_param}/attachments").to route_to(
        controller: 'attachments',
        action: 'create',
        task_id: @task.to_param
      )
    end
    it 'should route to #create for project' do
      expect(post: "/projects/#{@project.to_param}/attachments").to route_to(
        controller: 'attachments',
        action: 'create',
        project_id: @project.to_param
      )
    end
    it 'should route to #create for user' do
      expect(post: "/users/#{@user.to_param}/attachments").to route_to(
        controller: 'attachments',
        action: 'create',
        user_id: @user.to_param
      )
    end
  end
end
