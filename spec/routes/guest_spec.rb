require 'rails_helper'

RSpec.describe GuestController, type: :routing do
describe 'routing' do
    before :all do
    end
    it 'should route to #index' do
      expect(get: '/').to route_to(
        controller: 'guest',
        action: 'index'
      )
    end
  end
end
