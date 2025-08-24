defmodule GuessingGame do
  def compare(secret_number, guess \\ "")  
  def compare(secret_number, guess) when is_integer(guess) do
    case guess do
      x when x == secret_number -> "Correct"
      x when x == secret_number + 1 or guess == secret_number - 1 -> "So close"
      x when x > secret_number -> "Too high"
      x when x < secret_number -> "Too low"      
    end
  end
  def compare(_secret_number, guess) do
    "Make a guess"
  end
end
