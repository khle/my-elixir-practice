defmodule BasketballWebsite do
  # defp get_value_from_map([], map, acc \\ nil), do: acc

  defp get_value_from_map([head|tail], map) do
    if tail == [] do
      map[head]
    else
      sub_map_or_string = map[head]
      get_value_from_map(tail, sub_map_or_string)
    end
  end

  def extract_from_path(data, path) do
    get_value_from_map(String.split(path, "."), data)
  end

  def get_in_path(data, path) do
      get_in(data, String.split(path, "."))
  end
end
