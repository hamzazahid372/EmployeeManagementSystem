class AttendanceController < ApplicationController
  def log_in
    Current.user.current_attendance.update(login_time: DateTime.now)
    redirect_to :back
  end

  def log_out
    Current.user.current_attendance.update(logout_time: DateTime.now)
    binding.pry
    redirect_to :back
  end
end
