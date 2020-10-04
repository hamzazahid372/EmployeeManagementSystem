class TaskMailer < ApplicationMailer
  def notify(user_id, task_id, company_id)
    Current.company_id = company_id
    @user = User.find user_id
    @task = Task.find task_id
    mail(to: @user.email, subject: "#{Current.company.name} | #{@task.title} | Update")
  end
end
