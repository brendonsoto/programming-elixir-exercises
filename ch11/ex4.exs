defmodule StringCalc do
  def eval(str) do
    exp_without_spaces = Enum.reject str, &([&1] === ' ')
    first_num = Enum.take_while exp_without_spaces, &([&1] >= '0' && [&1] <= '9')
    operator = [hd (exp_without_spaces -- first_num)]
    second_num = tl (exp_without_spaces -- first_num -- operator)

    do_math(
      List.to_integer(first_num),
      operator,
      List.to_integer(second_num)
    )
  end

  def do_math(x, '+', y) do
    x + y
  end
  def do_math(x, '-', y) do
    x - y
  end
  def do_math(x, '*', y) do
    x * y
  end
  def do_math(x, '/', y) do
    x / y
  end
end

IO.puts StringCalc.eval('123 + 27')
