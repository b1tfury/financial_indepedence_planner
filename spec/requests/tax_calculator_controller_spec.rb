require 'rails_helper'

RSpec.describe "TaxCalculatorControllers", type: :request do
  describe "GET /tax_calculator" do
    it 'returns 200' do
      get '/tax_calculator'

      expect(response).to have_http_status(:ok)
    end
  end
end
