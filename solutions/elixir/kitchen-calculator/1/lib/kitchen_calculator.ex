defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    {_cup, volume} = volume_pair
    volume
  end

  def to_milliliter(volume_pair) do
    {cup, volume} = volume_pair
    case cup do
      :cup -> {:milliliter, volume * 240}
      :fluid_ounce -> {:milliliter, volume * 30}
      :teaspoon -> {:milliliter, volume * 5}
      :tablespoon -> {:milliliter, volume * 15}
      :milliliter -> {:milliliter, volume}
      _ -> {:milliliter, volume}
    end
  end

  def from_milliliter(volume_pair, unit) do
    {cup, volume} = volume_pair
    case unit do
      :cup -> {unit, volume / 240}
      :fluid_ounce -> {unit, volume / 30}
      :teaspoon -> {unit, volume / 5}
      :tablespoon -> {unit, volume / 15}
      :milliliter -> {unit, volume}
      _ -> {unit, volume}
    end
  end

  def convert(volume_pair, unit) do
    {_cup, volume} = volume_pair
    milimiter_pair = to_milliliter(volume_pair)
    {_, new_volume} = milimiter_pair
    from_milliliter({:milimiter, new_volume}, unit)
  end
end
