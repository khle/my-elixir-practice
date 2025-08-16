defmodule PaintByNumber do
  defp find_smallest_bitsize(n, color_count) do
    if 2 ** n >= color_count, do: n,
    else: find_smallest_bitsize(n + 1, color_count)
  end
  def palette_bit_size(color_count) do
      find_smallest_bitsize(0, color_count)
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    smallest_bitsize = palette_bit_size(color_count)
    <<pixel_color_index::size(smallest_bitsize), picture::bitstring>>
  end

  def get_first_pixel(picture, color_count) do
    if picture == <<>> do
      nil
    else
      smallest_bitsize = palette_bit_size(color_count)
      bit_size = bit_size(picture)
      remaining_bits = bit_size - smallest_bitsize

      IO.puts smallest_bitsize
      IO.puts remaining_bits
    
      <<head::size(smallest_bitsize), _rest::size(remaining_bits)>> = picture
      head
    end
  end

  def drop_first_pixel(picture, color_count) do
    if picture == <<>> do
      <<>>
    else
      smallest_bitsize = palette_bit_size(color_count)
      bit_size = bit_size(picture)
      remaining_bits = bit_size - smallest_bitsize

      IO.puts smallest_bitsize
      IO.puts remaining_bits
    
      <<_head::size(smallest_bitsize), rest::size(remaining_bits)>> = picture
      <<rest::size(remaining_bits)>>
    end
  end

  def concat_pictures(picture1, picture2) do
    case {picture1, picture2} do
      {<<>>, <<>>} -> <<>>
      {picture1, <<>>} -> picture1
      {<<>>, picture2} -> picture2
      _ ->
        # Not necessary, could be simplified for both cases
        # using <<picture1::bitstring, picture2::bitstring>>
        case bit_size(picture1) == bit_size(picture2) do
          true -> picture1 <> picture2 
          false -> <<picture1::bitstring, picture2::bitstring>>
        end
    end
  end
end
