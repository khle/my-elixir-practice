defmodule Username do
  defp match_and_replace([], _pattern, _replaced_with), do: []
  defp match_and_replace([pattern | tail], pattern, replaced_with) do
    replaced_with ++ match_and_replace(tail, pattern, replaced_with)
  end
  defp match_and_replace([head | tail], pattern, replaced_with) do
    [head | match_and_replace(tail, pattern, replaced_with)]
  end
  def sanitize(username) do
    # ä becomes ae
    # ö becomes oe
    # ü becomes ue
    # ß becomes ss
    sanitized_username = username
      |> match_and_replace(?ä, ~c"ae")
      |> match_and_replace(?ö, ~c"oe")
      |> match_and_replace(?ü, ~c"ue")
      |> match_and_replace(?ß, ~c"ss")
      #|> Enum.filter(&(&1 >= ?a and &1 <= ?z) or &1 == ?_)
      |> Enum.filter(fn char -> 
        case {char >= ?a and char <= ?z, char == ?_} do
          {true, _} -> true
          {_, true} -> true
          {false, false} -> false
        end
      end)

    sanitized_username
  end
end
