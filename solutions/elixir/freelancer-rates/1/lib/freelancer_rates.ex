defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    hourly_rate * 8.0
  end

  def apply_discount(before_discount, discount) do
    before_discount - discount * before_discount * 0.01
  end

  def monthly_rate(hourly_rate, discount) do
       trunc(Float.ceil(FreelancerRates.apply_discount(FreelancerRates.daily_rate(hourly_rate) * 22, discount)))
  end

  def days_in_budget(budget, hourly_rate, discount) do
    days_covered = Float.floor(budget / apply_discount(daily_rate(hourly_rate), discount), 1)
    days_covered
  end
end
