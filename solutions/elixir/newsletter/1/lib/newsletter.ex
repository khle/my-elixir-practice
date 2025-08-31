defmodule Newsletter do
  def read_emails(path) do
    content = File.read!(path)
    String.split(content, "\n", trim: true)
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, email)
  end

  def close_log(pid) do
    File.close(pid)
  end

  defp mail_and_log([], _send_fun, _pid) do
    :ok
  end

  defp mail_and_log([email| tail], send_fun, pid) do
    result = send_fun.(email)
    if result == :ok, do: log_sent_email(pid, email)
    mail_and_log(tail, send_fun, pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    emails = read_emails(emails_path)
    pid = open_log(log_path)
    mail_and_log(emails, send_fun, pid)
    close_log(pid)
  end
end
