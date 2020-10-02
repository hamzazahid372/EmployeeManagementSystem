module TasksHelper

  def watch_button task
    if (task.watcher_users.ids.include?(current_user.id))
      button_to 'Unwatch', tasks_watcher_path(current_user.tasks_watchers.find_by(task_id: task.id)), class: 'ml-3 btn btn-dark', method: :delete, remote: true
    else
      button_to 'Watch', task_tasks_watchers_path(task, { tasks_watcher: { watcher_id: current_user.id, watcher_type: 'User' }, reload: true}), class: 'ml-3 btn btn-dark', method: :post, remote: true
    end
  end

end
