# frozen_string_literal: true

require 'faker'

def info(msg)
  puts '+++++++++++++++++++++++++++'
  puts msg
  puts '+++++++++++++++++++++++++++'
end

info('Cleaning')
DatabaseCleaner.clean_with(:truncation)

info('Company')
# Creating Company
company = Company.create!(name: '7vals', subdomain: '7vals', owner_id: 1)

# set current tenant
Current.company_id = company.id

info('Owner')
owner = User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
                     email: 'admin@7vals.com',
                     password: '123456789', role_id: 1,
                     company_id: 1, confirmed_at: Date.today)

info('Employees')
1.upto(9) do |i|
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
               email: "user#{i}@7vals.com",
               password: '123456789', role_id: 2,
               department_id: rand(1..9),
               company_id: company.id, confirmed_at: Date.today)
end

info('Departments')
1.upto(9) do |i|
  Department.create!(name: Faker::Company.buzzword.titleize, description: Faker::Lorem.sentence)
end

info('Projects and Tasks')
# Creating 10 Projects each having 9 tasks, total 90 tasks
1.upto(10) do |i|
  project = Project.create!(name: Faker::Company.buzzword.titleize, description: Faker::Lorem.sentence,
                            company_id: company.id, created_by_id: owner.id, status: Project::STATUS.sample)

  3.times do
    department_id = user_id = rand(2..9)
    Department.find(department_id).projects << project rescue nil
    project.users << User.find(user_id) if project.users.ids.exclude?(user_id)
  end
  1.upto(9) do |j|
    Task.create!(title: Faker::Company.buzzword.titleize, description: Faker::Lorem.sentence,
                 company_id: company.id,
                 assignee: User.find(rand(1..9)),
                 reviewer_id: rand(1..9),
                 project_id: project.id,
                 created_by_id: owner.id,
                 priority: Task::PRIORITY.values.sample,
                 status: Task::STATUS.values.sample,
                 due_date: Date.new(2020, 10, rand(16..30)), start_date: Date.new(2020, 10, rand(1..15)))
  end
end

info('Teams')
1.upto(10) do |i|
  team = Team.create!(name: Faker::Company.name, company_id: company.id, lead: owner, created_by_id: owner.id, sequence_num: i)
  5.times do
    user = User.find(rand(1..10))
    team.users << user unless team.users.ids.include?(user.id)
  end
end

info('Task Watchers')
50.times do
  task = Task.find(rand(1..90))
  user = User.find(rand(1..10))
  team = Team.find(rand(1..10))
  task.watcher_users << user unless task.watcher_users.ids.include?(user.id)
  task.watcher_teams << team unless task.watcher_teams.ids.include?(team.id)
end

