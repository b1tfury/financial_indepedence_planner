class IncomeTaxCalculator
  NO_INCOME_TAX = 0.0
  MAX_NON_TAXABLE_INCOME_AMOUNT = 250000
  INCOME_TAX_RATE_FOR_INCOME_RANGE_250000_AND_500000 = 0.05
  INCOME_TAX_RATE_FOR_INCOME_RANGE_500000_AND_1000000 = 0.2
  INCOME_TAX_RATE_FOR_INCOME_ABOVE_1000000 = 0.30
  SURCHARGE_TAX_RATE_FOR_INCOME_RANGE_50L_AND_1C = 0.10
  SURCHARGE_TAX_RATE_FOR_INCOME_RANGE_1C_AND_2C = 0.15
  SURCHARGE_TAX_RATE_FOR_INCOME_RANGE_2C_AND_5C = 0.25
  MAX_AMOUNT_IN_TAX_SLAB_1 = 500000
  MAX_AMOUNT_IN_TAX_SLAB_2 = 1000000
  MAX_AMOUNT_WITHOUT_SURCHARGE_TAX_1 = 5000000
  MAX_AMOUNT_IN_SURCHARGE_TAX_SLAB_1 = 10000000
  MAX_AMOUNT_IN_SURCHARGE_TAX_SLAB_2 = 20000000
  HEALTH_CESS_RATE = 0.04

  def initialize(total_income)
    @total_income = total_income
  end

  def get_tax
    (calculate_income_tax_only + calculate_surcharge_tax_only) * (1 + HEALTH_CESS_RATE)
  end

  def calculate_income_tax_only
    if @total_income <= MAX_NON_TAXABLE_INCOME_AMOUNT
      NO_INCOME_TAX
    elsif @total_income <= MAX_AMOUNT_IN_TAX_SLAB_1
      (@total_income - MAX_NON_TAXABLE_INCOME_AMOUNT) * INCOME_TAX_RATE_FOR_INCOME_RANGE_250000_AND_500000
    elsif @total_income <= MAX_AMOUNT_IN_TAX_SLAB_2
      max_income_tax_in_tax_slab_1 + income_tax_in_tax_slab_2
    elsif @total_income <= MAX_AMOUNT_WITHOUT_SURCHARGE_TAX_1
      max_income_tax_in_tax_slab_1 + max_income_tax_in_tax_slab_2 + income_tax_in_tax_slab_3
    elsif @total_income <= MAX_AMOUNT_IN_SURCHARGE_TAX_SLAB_1
      income_tax = max_income_tax_in_tax_slab_1 + max_income_tax_in_tax_slab_2 + income_tax_in_tax_slab_3
      income_tax
    elsif @total_income <= MAX_AMOUNT_IN_SURCHARGE_TAX_SLAB_2
      income_tax = max_income_tax_in_tax_slab_1 + max_income_tax_in_tax_slab_2 + income_tax_in_tax_slab_3
      income_tax
    else
      income_tax = max_income_tax_in_tax_slab_1 + max_income_tax_in_tax_slab_2 + income_tax_in_tax_slab_3
      income_tax
    end
  end

  def calculate_surcharge_tax_only
    if @total_income <= MAX_AMOUNT_WITHOUT_SURCHARGE_TAX_1
      0
    elsif @total_income <= MAX_AMOUNT_IN_SURCHARGE_TAX_SLAB_1
      income_tax = max_income_tax_in_tax_slab_1 + max_income_tax_in_tax_slab_2 + income_tax_in_tax_slab_3
      income_tax * SURCHARGE_TAX_RATE_FOR_INCOME_RANGE_50L_AND_1C
    elsif @total_income <= MAX_AMOUNT_IN_SURCHARGE_TAX_SLAB_2
      income_tax = max_income_tax_in_tax_slab_1 + max_income_tax_in_tax_slab_2 + income_tax_in_tax_slab_3
      income_tax * SURCHARGE_TAX_RATE_FOR_INCOME_RANGE_1C_AND_2C
    else
      income_tax = max_income_tax_in_tax_slab_1 + max_income_tax_in_tax_slab_2 + income_tax_in_tax_slab_3
      income_tax * SURCHARGE_TAX_RATE_FOR_INCOME_RANGE_2C_AND_5C
    end
  end

  private

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
end
