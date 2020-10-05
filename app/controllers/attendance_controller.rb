class AttendanceController < ApplicationController
  def log_in
    if Current.user.current_attendance.login_time.nil?
      success = Current.user.current_attendance.update(login_time: Time.zone.now)
      if success
        flash[:success] = t 'attendance.login_marked'
      else
        flash[:error] = t 'attendance.login_not_marked'
      end
    else
      flash[:notice] = t 'login_marked_already'
    end
    redirect_to request.referer
  end

  def log_out
    if Current.user.current_attendance.logout_time.nil?
      success = Current.user.current_attendance.update(logout_time: Time.zone.now)
      if success
        flash[:success] = t 'attendance.logout_marked'
      else
        flash[:error] = t 'attendance.logout_not_marked'
      end
    else
      flash[:notice] = t 'logout_marked_already'
    end
    redirect_to request.referer
  end
end
