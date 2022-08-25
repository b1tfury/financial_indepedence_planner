class IncomeTaxCalculator
  MAX_NON_TAXABLE_INCOME_AMOUNT = 250000
  INCOME_TAX_RATE_FOR_INCOME_RANGE_250000_AND_500000 = 0.05
  INCOME_TAX_RATE_FOR_INCOME_RANGE_500000_AND_1000000 = 0.2
  INCOME_TAX_RATE_FOR_INCOME_ABOVE_1000000 = 0.30
  SURCHARGE_TAX_RATE_FOR_INCOME_RANGE_50L_AND_1C = 0.10
  SURCHARGE_TAX_RATE_FOR_INCOME_RANGE_1C_AND_2C = 0.20
  MAX_AMOUNT_IN_TAX_SLAB_1 = 500000
  MAX_AMOUNT_IN_TAX_SLAB_2 = 1000000
  MAX_AMOUNT_WITHOUT_SURCHARGE_TAX_1 = 5000000
  MAX_AMOUNT_IN_SURCHARGE_TAX_SLAB_1 = 10000000

  def initialize(total_income)
    @total_income = total_income
  end

  def get_tax
    if @total_income <= MAX_NON_TAXABLE_INCOME_AMOUNT
      0.0
    elsif @total_income <= MAX_AMOUNT_IN_TAX_SLAB_1
      (@total_income - MAX_NON_TAXABLE_INCOME_AMOUNT) * INCOME_TAX_RATE_FOR_INCOME_RANGE_250000_AND_500000
    elsif @total_income <= MAX_AMOUNT_IN_TAX_SLAB_2
      max_income_tax_in_tax_slab_1 + income_tax_in_tax_slab_2
    elsif @total_income <= MAX_AMOUNT_WITHOUT_SURCHARGE_TAX_1
      max_income_tax_in_tax_slab_1 + max_income_tax_in_tax_slab_2 + income_tax_in_tax_slab_3
    elsif @total_income <= MAX_AMOUNT_IN_SURCHARGE_TAX_SLAB_1
      max_income_tax_in_tax_slab_1 + max_income_tax_in_tax_slab_2 + income_tax_in_tax_slab_3 +
        surcharge_tax_on_income_tax_for_range_50_and_1C
    else
      max_income_tax_in_tax_slab_1 + max_income_tax_in_tax_slab_2 + income_tax_in_tax_slab_3 +
        max_surcharge_tax_on_surcharge_tax_slab_1 + surcharge_tax_on_income_tax_amount_range_1C_and_2C
    end
  end

  private

  def surcharge_tax_on_income_tax_amount_range_1C_and_2C
    income_amount_eligible_for_surcharge_tax_2 = @total_income - MAX_AMOUNT_IN_SURCHARGE_TAX_SLAB_1
    income_tax_amount_eligible_for_surcharge_tax_2 = income_amount_eligible_for_surcharge_tax_2 * INCOME_TAX_RATE_FOR_INCOME_ABOVE_1000000
    income_tax_amount_eligible_for_surcharge_tax_2 * SURCHARGE_TAX_RATE_FOR_INCOME_RANGE_1C_AND_2C
  end

  def income_tax_in_tax_slab_2
    (@total_income - MAX_AMOUNT_IN_TAX_SLAB_1) * INCOME_TAX_RATE_FOR_INCOME_RANGE_500000_AND_1000000
  end

  def income_tax_in_tax_slab_3
    (@total_income - MAX_AMOUNT_IN_TAX_SLAB_2) * INCOME_TAX_RATE_FOR_INCOME_ABOVE_1000000
  end

  def max_income_tax_in_tax_slab_2
    (MAX_AMOUNT_IN_TAX_SLAB_2 - MAX_AMOUNT_IN_TAX_SLAB_1) * INCOME_TAX_RATE_FOR_INCOME_RANGE_500000_AND_1000000
  end

  def max_income_tax_in_tax_slab_1
    (MAX_AMOUNT_IN_TAX_SLAB_1 - MAX_NON_TAXABLE_INCOME_AMOUNT) * INCOME_TAX_RATE_FOR_INCOME_RANGE_250000_AND_500000
  end

  def max_surcharge_tax_on_surcharge_tax_slab_1
    income_amount_eligible_for_surcharge_tax_1 = MAX_AMOUNT_IN_SURCHARGE_TAX_SLAB_1 - MAX_AMOUNT_WITHOUT_SURCHARGE_TAX_1
    income_tax_amount_eligible_for_surcharge_tax_1 = income_amount_eligible_for_surcharge_tax_1 * INCOME_TAX_RATE_FOR_INCOME_ABOVE_1000000
    income_tax_amount_eligible_for_surcharge_tax_1 * SURCHARGE_TAX_RATE_FOR_INCOME_RANGE_50L_AND_1C
  end

  def surcharge_tax_on_income_tax_for_range_50_and_1C
    income_amount_eligible_for_surcharge_tax_1 = @total_income - MAX_AMOUNT_WITHOUT_SURCHARGE_TAX_1
    income_tax_amount_eligible_for_surcharge_tax_1 = income_amount_eligible_for_surcharge_tax_1 * INCOME_TAX_RATE_FOR_INCOME_ABOVE_1000000
    income_tax_amount_eligible_for_surcharge_tax_1 * SURCHARGE_TAX_RATE_FOR_INCOME_RANGE_50L_AND_1C
  end
end
