defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, fn item -> item.price end, :asc)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, fn item -> item.price == nil end)
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn 
      item -> %{ price: item.price, name: String.replace(item.name, old_word, new_word), quantity_by_size: item.quantity_by_size } 
      end)
  end

  def increase_quantity(item, count) do
     %{name: item.name, price: item.price, quantity_by_size: 
     Map.new(item.quantity_by_size, fn {key, val} -> {key, val + count} end)}
  end

  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, fn {_key, val}, acc -> acc + val end)
  end
end
