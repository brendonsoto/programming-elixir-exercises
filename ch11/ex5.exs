defmodule Ex do
  def center(list) do
    max_length = list |> (Enum.map &(String.length(&1))) |> Enum.max
    Enum.map list, &(apply_padding(max_length, &1))
  end

  defp apply_padding(max_length, str) do
    front_pad_length = div(max_length, 2) + div(String.length(str), 2)
    str
    |> String.pad_leading(front_pad_length)
    |> String.pad_trailing(max_length)
  end
end


Ex.center(["cat", "zebra", "elephant"])
|> (Enum.each &(IO.puts &1))
