tax_rates = [NC: 0.075, TX: 0.08]

orders = [
  [ id: 123, ship_to: :NC, net_amount: 100.00 ],
  [ id: 124, ship_to: :OK, net_amount: 35.00 ],
  [ id: 125, ship_to: :TX, net_amount: 24.00 ],
  [ id: 126, ship_to: :TX, net_amount: 44.00 ],
  [ id: 127, ship_to: :NC, net_amount: 25.00 ],
  [ id: 128, ship_to: :MA, net_amount: 10.00 ],
  [ id: 129, ship_to: :CA, net_amount: 102.00 ],
  [ id: 130, ship_to: :NC, net_amount: 50.00 ]
]


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
end


updated_orders = Pricing.get_orders tax_rates, orders
# IO.puts inspect(updated_orders)
Enum.each updated_orders, &(IO.puts inspect(&1))
