class UserPresenter
  attr_reader :user, :view
 
  def initialize(user, view)
    @user = user
    @view = view
  end

  def role
    User::ROLES.key(user.role_id)
  end

  def department
    return if user.department.nil?

    view.link_to user.department.name, view.department_path(user.department)
  end
end
