class GuestController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    redirect_to dashboard_path and return if Current.user.present?

    redirect_to root_url(subdomain: '') and return if Current.company.present?

    respond_to do |format|
      format.html
    end
  end
end
