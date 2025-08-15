defmodule HighSchoolSweetheart do
  def first_letter(name) do
    name
    |> String.trim()
    |> String.first()
  end

  def initial(name) do
    name
    |> String.trim()
    |> String.first()
    |> String.upcase()
    |> Kernel.<>(".")
  end

  def initials(full_name) do
    full_name_trimmed = String.replace(full_name, "", "")
    [ first, last | _ ] = String.split(full_name_trimmed)
    initial(first) <> " " <> initial(last)
  end

  def pair(full_name1, full_name2) do
    # ❤-------------------❤
    # |  X. X.  +  X. X.  |
    # ❤-------------------❤

    """
    ❤-------------------❤
    |  #{initials(full_name1)}  +  #{initials(full_name2)}  |
    ❤-------------------❤
    """
    
    
  end
end
