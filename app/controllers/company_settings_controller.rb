# frozen_string_literal: true

# Company Settings Controller
class CompanySettingsController < ApplicationController
  load_and_authorize_resource
  # GET /company_settings/:id
  def show
    @working_days = Current.company.working_days
  end

  #  PATCH /company_settings/:id
  def update
    if @company_setting.update(company_setting_params)
      flash[:notice] = t 'company_setting.updated'
    else
      flash[:error] = @company_setting.errors.full_messages
    end
    redirect_to @company_setting
  end

  private

  def company_setting_params
    params.require(:company_setting).permit(:time_zone, :leaves)
  end
end
