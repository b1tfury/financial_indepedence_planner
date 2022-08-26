require 'rails_helper'
RSpec.describe 'Routes for tax calculator', type: :routing do

  it 'routes GET /tax_calculator to TaxCalulator#show' do
    expect(get('/tax_calculator')).to route_to(:controller => 'tax_calculator', action: 'show')
  end
end
