require 'rails_helper'

RSpec.describe "Reports", type: :request do

  describe "GET /task" do
    it "returns http success" do
      get "/reports/task"
      expect(response).to have_http_status(:success)
    end
  end

end
