defmodule LogLevel do
  def to_label(level, legacy?) do
    if legacy? do      
      cond do
        level == 0 -> :unknown
        level == 1 -> :debug
        level == 2 -> :info
        level == 3 -> :warning
        level == 4 -> :error
        level == 5 -> :unknown
        true -> :unknown
      end
    else      
      cond do
        level == 0 -> :trace
        level == 1 -> :debug
        level == 2 -> :info
        level == 3 -> :warning
        level == 4 -> :error
        level == 5 -> :fatal
        true -> :unknown
      end  
    end
  end

  def alert_recipient(level, legacy?) do
    log_label = LogLevel.to_label(level, legacy?)
    cond do
      log_label == :error -> :ops
      log_label == :fatal -> :ops
      log_label == :unknown and legacy? -> :dev1
      log_label == :unknown -> :dev2
      true -> false
    end
  end
end
