require 'rails_helper'

RSpec.describe IncomeTaxCalculator, type: :helper do
  context 'when total income is less than minimum taxable income' do
    it 'total tax on total income should be 0' do
      income_tax = IncomeTaxCalculator.new(50000)

      minimum_taxable_income = income_tax.calculate_minimum_taxable_income

      expect(minimum_taxable_income).to be_eql(0.0)
    end
  end

  context 'when total income is more than minimum taxable income' do
    it 'returns 5% of income for the range between 2.5 lac to 5 lacs' do
      income_tax = IncomeTaxCalculator.new(450000)

      minimum_taxable_income = income_tax.calculate_minimum_taxable_income

      expect(minimum_taxable_income).to be_eql(10000.0)
    end

    it 'returns additional 20% of income for range between 5 lacs to 10 lacs' do
      taxable_amount = 950000
      extra_amount_in_this_income_range = taxable_amount - 500000
      income_tax_calculator = IncomeTaxCalculator.new(taxable_amount)
      another_income_tax_calculator = IncomeTaxCalculator.new(500000)
      income_tax_on_500000 = another_income_tax_calculator.calculate_minimum_taxable_income
      total_expected_income_tax = income_tax_on_500000 + extra_amount_in_this_income_range * 0.20

      minimum_taxable_income = income_tax_calculator.calculate_minimum_taxable_income

      expect(minimum_taxable_income).to be_eql(total_expected_income_tax)
    end
  end
end