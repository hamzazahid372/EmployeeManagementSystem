# frozen_string_literal: true

# Sessions Controller
class SessionsController < Devise::SessionsController
  #  GET /user/sign_in
  def new
    redirect_to user_companies_find_path and return if Current.company.nil?

    super
  end
end
