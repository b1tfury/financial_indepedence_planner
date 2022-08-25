class IncomeTaxCalculator
  MAX_NON_TAXABLE_INCOME_AMOUNT = 250000
  INCOME_TAX_RATE_FOR_INCOME_RANGE_250000_AND_500000 = 0.05

  def initialize(total_income)
    @total_income = total_income
  end

  def calculate_minimum_taxable_income
    if @total_income <= MAX_NON_TAXABLE_INCOME_AMOUNT
      0
    else
      (@total_income - MAX_NON_TAXABLE_INCOME_AMOUNT) * INCOME_TAX_RATE_FOR_INCOME_RANGE_250000_AND_500000
    end
  end
end
