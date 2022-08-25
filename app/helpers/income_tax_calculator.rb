class IncomeTaxCalculator
  MAX_NON_TAXABLE_INCOME_AMOUNT = 250000
  INCOME_TAX_RATE_FOR_INCOME_RANGE_250000_AND_500000 = 0.05
  INCOME_TAX_RATE_FOR_INCOME_RANGE_500000_AND_1000000 = 0.2
  INCOME_TAX_RATE_FOR_INCOME_ABOVE_1000000 = 0.30
  SURCHARGE_TAX_RATE_FOR_INCOME_RANGE_50L_AND_1C = 0.10
  MAX_AMOUNT_IN_TAX_SLAB_1 = 500000
  MAX_AMOUNT_IN_TAX_SLAB_2 = 1000000
  MAX_AMOUNT_WITHOUT_SURCHARGE_TAX_1 = 5000000

  def initialize(total_income)
    @total_income = total_income
  end

  def get_tax
    if @total_income <= MAX_NON_TAXABLE_INCOME_AMOUNT
      0.0
    elsif @total_income <= MAX_AMOUNT_IN_TAX_SLAB_1
      (@total_income - MAX_NON_TAXABLE_INCOME_AMOUNT) * INCOME_TAX_RATE_FOR_INCOME_RANGE_250000_AND_500000
    elsif @total_income <= MAX_AMOUNT_IN_TAX_SLAB_2
      income_in_tax_slab_2 = @total_income - MAX_AMOUNT_IN_TAX_SLAB_1
      income_tax_for_tax_slab_2 = income_in_tax_slab_2 * INCOME_TAX_RATE_FOR_INCOME_RANGE_500000_AND_1000000
      max_income_tax_in_tax_slab_1 + income_tax_for_tax_slab_2
    elsif @total_income <= MAX_AMOUNT_WITHOUT_SURCHARGE_TAX_1
      income_in_tax_slab_3 = @total_income - MAX_AMOUNT_IN_TAX_SLAB_2
      income_tax_for_tax_slab_3 = income_in_tax_slab_3 * INCOME_TAX_RATE_FOR_INCOME_ABOVE_1000000
      max_income_tax_in_tax_slab_1 + max_income_tax_in_tax_slab_2 + income_tax_for_tax_slab_3
    else
      income_in_tax_slab_3 = @total_income - MAX_AMOUNT_IN_TAX_SLAB_2
      income_tax_for_tax_slab_3 = income_in_tax_slab_3 * INCOME_TAX_RATE_FOR_INCOME_ABOVE_1000000
      income_amount_eligible_for_surcharge_tax = @total_income - MAX_AMOUNT_WITHOUT_SURCHARGE_TAX_1
      income_tax_amount_eligible_for_surcharge_tax = income_amount_eligible_for_surcharge_tax * INCOME_TAX_RATE_FOR_INCOME_ABOVE_1000000
      surcharge_tax_on_income_tax_amount_for_range_50L_and_1C =
        income_tax_amount_eligible_for_surcharge_tax * SURCHARGE_TAX_RATE_FOR_INCOME_RANGE_50L_AND_1C
      max_income_tax_in_tax_slab_1 + max_income_tax_in_tax_slab_2 + income_tax_for_tax_slab_3 + surcharge_tax_on_income_tax_amount_for_range_50L_and_1C
    end
  end

  private

  def max_income_tax_in_tax_slab_2
    (MAX_AMOUNT_IN_TAX_SLAB_2 - MAX_AMOUNT_IN_TAX_SLAB_1) * INCOME_TAX_RATE_FOR_INCOME_RANGE_500000_AND_1000000
  end

  def max_income_tax_in_tax_slab_1
    (MAX_AMOUNT_IN_TAX_SLAB_1 - MAX_NON_TAXABLE_INCOME_AMOUNT) * INCOME_TAX_RATE_FOR_INCOME_RANGE_250000_AND_500000
  end
end
