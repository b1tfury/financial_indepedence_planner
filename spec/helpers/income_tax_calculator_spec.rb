require 'rails_helper'

RSpec.describe IncomeTaxCalculator, type: :helper do
  context 'when total income is less than minimum taxable income' do
    it 'total tax on total income should be 0' do
      income_tax = IncomeTaxCalculator.new('total_income' => 50000)

      minimum_taxable_income = income_tax.calculate_minimum_taxable_income

      expect(minimum_taxable_income).to be(0)
    end
  end
end