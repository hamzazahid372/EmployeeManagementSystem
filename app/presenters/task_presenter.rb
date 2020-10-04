class TaskPresenter
  attr_reader :task
 
  def initialize(task)
    @task = task
  end

  def priority
    Task::PRIORITY.key task.priority
  end

  def progress
    "#{task.progress.to_i} %"
  end

end
