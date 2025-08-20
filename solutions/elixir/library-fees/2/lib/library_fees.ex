defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime
      |> NaiveDateTime.to_time()
      |> Time.before?(~T[12:00:00])
  end

  def return_date(checkout_datetime) do
    case before_noon?(checkout_datetime) do
      true ->
        checkout_datetime
          |> NaiveDateTime.add(28, :day)
          |> NaiveDateTime.to_date()
      false -> 
        checkout_datetime
          |> NaiveDateTime.add(29, :day)
          |> NaiveDateTime.to_date()
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    days_late = actual_return_datetime
      |> NaiveDateTime.to_date()
      |> Date.diff(planned_return_date)
    case days_late > 0 do
      true -> days_late
      false -> 0
    end
  end

  def monday?(datetime) do
    Date.day_of_week(datetime) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_datetime = datetime_from_string(checkout) #~N    
    scheduled_return_date = return_date(checkout_datetime) # ~D
    return_datetime = datetime_from_string(return) #~N   
    number_of_days_late = days_late(scheduled_return_date, return_datetime)    
    case number_of_days_late >= 1 do
      true ->
        case monday?(NaiveDateTime.to_date(return_datetime)) do
          true -> Integer.floor_div(number_of_days_late * rate, 2)
          false -> number_of_days_late * rate
        end
      false -> 0
    end
  end
end
