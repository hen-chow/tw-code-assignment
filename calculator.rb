class Calculator

  def calculate_currency(str_val, overall_value)
    # calculate the individual value of each currency to use as a multiplier
    currency_val = overall_value.fdiv(str_val)
  end

  def calculate_credits(currency_val, str_val)
    # use to calculate total credits
    result = str_val * currency_val
  end

end
