defmodule LogParser do
  def valid_line?(line) do
    line =~ ~r/^\[DEBUG\]|\[INFO\]|\[WARNING\]|\[ERROR\]/u
  end

  def split_line(line) do    
    Regex.split(~r/\<(\=|\~|\*|\-)*\>/, line)
  end

  def remove_artifacts(line) do
    # look-behind for no space scenario
    Regex.replace(~r/(?<!\s)end-of-line\d+|end-of-line\d+/i, line, "")    
  end

  def tag_with_user_name(line) do
    String.replace(line, ~r/(?:\s|\\[tn])+/i, " ")
    pattern = ~r/^\[([A-Z]+)\]\s*(?:.*?\bUser\s+([^\s]+)\s*(.*)|(.+))$/u

    Regex.replace(pattern, line, fn _, group_1, group_2, group_3 ->
      # IO.puts group_1
      # IO.puts group_2
      # IO.puts group_3
      case group_2 != "" do
        true -> "[USER] #{group_2} " <> line
        false -> line
      end
    end)
  end
end
