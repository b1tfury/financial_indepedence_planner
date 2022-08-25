class IncomeTaxCalculator
  MAX_NON_TAXABLE_INCOME_AMOUNT = 250000
  INCOME_TAX_RATE_FOR_INCOME_RANGE_250000_AND_500000 = 0.05
  INCOME_TAX_RATE_FOR_INCOME_RANGE_500000_AND_1000000 = 0.2
  INCOME_TAX_RATE_FOR_INCOME_ABOVE_1000000 = 0.30
  MAX_AMOUNT_IN_TAX_SLAB_1 = 500000
  MAX_AMOUNT_IN_TAX_SLAB_2 = 1000000

  def initialize(total_income)
    @total_income = total_income
  end

  def calculate_minimum_taxable_income
    if @total_income <= MAX_NON_TAXABLE_INCOME_AMOUNT
      0.0
    elsif @total_income <= MAX_AMOUNT_IN_TAX_SLAB_1
      (@total_income - MAX_NON_TAXABLE_INCOME_AMOUNT) * INCOME_TAX_RATE_FOR_INCOME_RANGE_250000_AND_500000
    elsif @total_income <= MAX_AMOUNT_IN_TAX_SLAB_2
      max_income_in_tax_slab_1 = MAX_AMOUNT_IN_TAX_SLAB_1 - MAX_NON_TAXABLE_INCOME_AMOUNT
      max_income_tax_in_tax_slab_1 = max_income_in_tax_slab_1 * INCOME_TAX_RATE_FOR_INCOME_RANGE_250000_AND_500000
      income_in_tax_slab_2 = @total_income - MAX_AMOUNT_IN_TAX_SLAB_1
      income_tax_for_tax_slab_2 = income_in_tax_slab_2 * INCOME_TAX_RATE_FOR_INCOME_RANGE_500000_AND_1000000
      max_income_tax_in_tax_slab_1 + income_tax_for_tax_slab_2
    else
      max_income_in_tax_slab_1 = MAX_AMOUNT_IN_TAX_SLAB_1 - MAX_NON_TAXABLE_INCOME_AMOUNT
      max_income_tax_in_tax_slab_1 = max_income_in_tax_slab_1 * INCOME_TAX_RATE_FOR_INCOME_RANGE_250000_AND_500000
      max_income_in_tax_slab_2 = MAX_AMOUNT_IN_TAX_SLAB_2 - MAX_AMOUNT_IN_TAX_SLAB_1
      max_income_tax_in_tax_slab_2 = max_income_in_tax_slab_2 * INCOME_TAX_RATE_FOR_INCOME_RANGE_500000_AND_1000000
      income_in_tax_slab_3 = @total_income - MAX_AMOUNT_IN_TAX_SLAB_2
      income_tax_for_tax_slab_3 = income_in_tax_slab_3 * INCOME_TAX_RATE_FOR_INCOME_ABOVE_1000000
      max_income_tax_in_tax_slab_1 + max_income_tax_in_tax_slab_2 + income_tax_for_tax_slab_3
    end
  end
end
