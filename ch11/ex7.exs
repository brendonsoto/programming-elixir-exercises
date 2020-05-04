tax_rates = [NC: 0.075, TX: 0.08]

defmodule Pricing do
  # Iterate through orders
  # Get the total by checking if the shipping is in tax rates
  def get_orders(tax_rates, orders) do
    Enum.map orders, fn(order) ->
      tax_rate = tax_rates[order[:ship_to]]
      total_amount = get_total(tax_rate, order[:net_amount])
      Keyword.merge(order, [total_amount: total_amount])
    end
  end

  def get_total(nil, net_amount), do: net_amount
  def get_total(tax, net_amount) do
    net_amount + net_amount * tax
  end

  def read_orders(file) do
    # Read file
    {:ok, contents} = File.open(file, [:read])

    # Get keywords
    keywords = IO.read(contents, :line)
               |> String.trim_trailing
               |> String.split(",")
               |> (Enum.map &(String.to_atom(&1)))

    # Map through each line splitting by commas and zipping with keywords
    formatted_data = Enum.map IO.stream(contents, :line),
      &(process_line(keywords, &1))

    # Close file
    File.close(file)

    # Return keyword-list of orders
    formatted_data
  end

  defp process_line(keywords, line) do
    values = line
             |> String.trim_trailing
             |> String.split(",")
             |> convert_string_to_type
    pairs = Enum.zip(keywords, values)
    Keyword.new(pairs)
  end

  defp convert_string_to_type([a,b,c]) do
    [a, String.to_atom(String.trim_leading(b, ":")), String.to_float(c)]
  end
end


orders = Pricing.read_orders("sales-info.txt")
updated_orders = Pricing.get_orders tax_rates, orders
Enum.each updated_orders, &(IO.puts inspect(&1))
