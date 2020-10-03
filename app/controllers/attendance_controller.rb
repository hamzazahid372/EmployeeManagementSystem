class AttendanceController < ApplicationController
  def log_in
    Current.user.current_attendance.update(login_time: DateTime.now)
    redirect_to request.referer
  end

  def log_out
    Current.user.current_attendance.update(logout_time: DateTime.now)
    redirect_to request.referer
  end
end
