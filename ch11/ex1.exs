defmodule Ex do
  def has_only_printable_ascii(str) do
    Enum.all? str, &([&1] >= ' ' && [&1] <='~')
  end
end
