require 'rails_helper'

RSpec.describe IncomeTaxCalculator, type: :helper do
  context 'when total income is less than minimum taxable income' do
    it 'total tax on total income should be 0' do
      income_tax = IncomeTaxCalculator.new(50000)

      minimum_taxable_income = income_tax.get_tax

      expect(minimum_taxable_income).to be_eql(0.0)
    end
  end

  context 'when total income is more than minimum taxable income but less than 50 lacs' do
    it 'returns 5% of income for the range between 2.5 lac to 5 lacs + health cess' do
      income_tax_calculator = IncomeTaxCalculator.new(450000)

      actual_income_tax = income_tax_calculator.get_tax

      expect(actual_income_tax).to eq(10400.0)
    end

    it 'returns additional 20% of income for range between 5 lacs to 10 lacs + health cess' do
      taxable_amount = 950000
      extra_amount_in_this_income_range = taxable_amount - 500000
      another_income_tax_calculator = IncomeTaxCalculator.new(500000)
      income_tax_on_500000 = another_income_tax_calculator.get_tax
      expected_total_tax = income_tax_on_500000 + (extra_amount_in_this_income_range * 0.20 * 1.04)

      income_tax_calculator = IncomeTaxCalculator.new(taxable_amount)
      actual_tax = income_tax_calculator.get_tax

      expect(actual_tax).to eq(expected_total_tax)
    end

    it 'returns additional 30% of income for all income above 10 lacs + health cess' do
      total_income_amount = 1500000
      TEN_LACS = 1000000
      extra_income_in_this_income_range = total_income_amount - TEN_LACS
      income_tax_calculator_till_10_lac = IncomeTaxCalculator.new(TEN_LACS)
      income_tax_on_10_lac = income_tax_calculator_till_10_lac.get_tax
      expected_tax = income_tax_on_10_lac + extra_income_in_this_income_range * 0.30 * 1.04

      income_tax_calculator = IncomeTaxCalculator.new(total_income_amount)
      actual_tax = income_tax_calculator.get_tax

      expect(actual_tax).to be_eql(expected_tax)
    end
  end

  context 'when total income is more than 50 lacs' do
    it 'returns additional 10% surcharge_tax on income tax on amount between 50 lacs and 1 crore + health cess' do
      total_income_amount = 7500000
      FIFTY_LACS = 5000000
      extra_income_in_this_income_range = total_income_amount - FIFTY_LACS
      income_tax_calculator_till_50_lacs = IncomeTaxCalculator.new(FIFTY_LACS)
      income_tax_on_50_lac = income_tax_calculator_till_50_lacs.calculate_income_tax_only

      income_tax_on_extra_income_in_this_range = extra_income_in_this_income_range * 0.30
      total_income_tax = income_tax_on_50_lac + income_tax_on_extra_income_in_this_range
      surcharge_tax = total_income_tax * 0.10
      expected_income_tax = (total_income_tax + surcharge_tax) * 1.04

      income_tax_calculator = IncomeTaxCalculator.new(total_income_amount)
      actual_income_tax = income_tax_calculator.get_tax

      expect(actual_income_tax).to eq(expected_income_tax)
    end
    it 'returns additional 15% surcharge_tax on income tax on amount between 1 crore and 2 crore + health cess' do
      total_income_amount = 17500000
      ONE_CRORE = 10000000
      extra_income_in_this_income_range = total_income_amount - ONE_CRORE
      income_tax_calculator_till_one_crore = IncomeTaxCalculator.new(ONE_CRORE)
      income_tax_on_one_crore = income_tax_calculator_till_one_crore.calculate_income_tax_only

      income_tax_on_extra_income_in_this_range = extra_income_in_this_income_range * 0.30
      total_income_tax = income_tax_on_one_crore + income_tax_on_extra_income_in_this_range
      surcharge_tax = (total_income_tax) * 0.15
      income_tax_and_surcharge = total_income_tax + surcharge_tax
      expected_income_tax = (income_tax_and_surcharge) * 1.04

      income_tax_calculator = IncomeTaxCalculator.new(total_income_amount)
      actual_income_tax = income_tax_calculator.get_tax

      expect(actual_income_tax).to eq(expected_income_tax)
    end

    it 'returns additional 25% surcharge_tax on income tax on amount between 2 crore and 5 crore' do
      total_income_amount = 47500000
      TWO_CRORE = 20000000
      extra_income_in_this_income_range = total_income_amount - TWO_CRORE
      income_tax_calculator_till_two_crore = IncomeTaxCalculator.new(TWO_CRORE)
      income_tax_on_two_crore = income_tax_calculator_till_two_crore.calculate_income_tax_only

      income_tax_on_extra_income_in_this_range = extra_income_in_this_income_range * 0.30
      total_income_tax = income_tax_on_two_crore + income_tax_on_extra_income_in_this_range
      surcharge_amount = total_income_tax * 0.25

      expected_income_tax = (income_tax_on_two_crore + income_tax_on_extra_income_in_this_range + surcharge_amount) * 1.04

      income_tax_calculator = IncomeTaxCalculator.new(total_income_amount)
      actual_income_tax = income_tax_calculator.get_tax

      expect(actual_income_tax).to eq(expected_income_tax)
    end
  end
end
