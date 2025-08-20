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

    Regex.replace(pattern, line, fn _, _group_1, username, _group_3 ->
      case username == "" do
        true -> line
        false -> "[USER] #{username} " <> line
      end
    end)
  end
end
