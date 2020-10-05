# frozen_string_literal: true

# Sessions Controller
class SessionsController < Devise::SessionsController
  def new
    redirect_to user_companies_find_path and return if Current.company.nil?

    super
  end
end
