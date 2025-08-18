defmodule WineCellar do
  def explain_colors do
    [
      {:white, "Fermented without skin contact."}, 
      {:red, "Fermented with skin contact using dark-colored grapes."}, 
      {:rose, "Fermented with some skin contact, but not enough to qualify as a red wine."}
    ]
  end

  defp filter_by_color([], _color), do: []
  defp filter_by_color([{color, wine} | tail], color) do
    [wine | filter_by_color(tail, color)]
  end
  defp filter_by_color([{_, _} | tail], color) do
    filter_by_color(tail, color)
  end
  
  def filter(cellar, color, opts \\ []) do
    year = Keyword.get(opts, :year, nil)
    country= Keyword.get(opts, :country, nil)
    # IO.puts("year: #{year}")
    # IO.puts("country: #{country}")
    case {year, country} do
      {nil, nil} -> filter_by_color(cellar, color)
      {year, nil} ->
        cellar
          |> filter_by_color(color)
          |> filter_by_year(year)
      {nil, country} ->
        cellar
          |> filter_by_color(color)
          |> filter_by_country(country)
      {year, country} ->
        cellar
          |> filter_by_color(color)
          |> filter_by_year(year)
          |> filter_by_country(country)
    end
  end

  # The functions below do not need to be modified.

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
