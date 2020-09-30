FactoryBot.define do
  factory :time_log do
    hours { 3.5 }
    activity_id { 2 }
  end
  factory :task do
    title { Faker::Name.name }
    status { 'Pending' }
    priority { 2 }
  end
  factory :project do
    name { 'Sample project' }
    status { 'Pending' }
  end
  factory :employee, class: User do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    role_id { 2 }
    department_id { 1 }
    email { Faker::Internet.email }
    password { '123456' }
  end
  factory :admin, class: User do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    role_id { 1 }
    department_id { 1 }
    email { Faker::Internet.email }
    password { '123456' }
  end
  factory :company do
    name { '7vals' }
    subdomain { '7vals' }
  end
end