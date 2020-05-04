# Below are my initial attempts
# I had to look at the Erlang source code to figure this one out
# I felt like I was on the right track with thinking:
# "Is the head a list? If so, call the function recursively over that and then combine with the result of recursively calling the function on the tail"
# But then I realized if I do that, then I'd be left with an empty list as the
# end of the flattened inner list and basically am stuck with a list
# I was stuck on this one
# I also kept thinking it had to be within one function

# From Erlang source: https://github.com/erlang/otp/blob/master/lib/stdlib/src/lists.erl

defmodule MyList do
  def flatten(list) when is_list list do
    # A sub function is used where an empty list is used as an accumulator
    do_flatten(list, [])
  end

  # The first case is to cover when the head is a list itself
  # We call the helper function again but with the head passed in as the list
  # and the tail is another call to the helper function, but with the
  # tail of the inner list and the accumulator
  def do_flatten([subHead | subTail], tail) when is_list subHead do
    do_flatten(subHead, do_flatten(subTail, tail))
  end
  # In the case that the head is not a list, simply create a list with the
  # head as the first elem and the rest being the result of calling the
  # helper function again but with the tail of the list and the accumulator
  def do_flatten([subHead | subTail], tail) do
    [subHead | do_flatten(subTail, tail)]
  end
  # This is to cover when the first list is empty, just result in the tail
  def do_flatten([], tail) do
    tail
  end
end

my_list = MyList.flatten([1, [2, 3, [4]], 5])
IO.puts inspect(my_list)


# defmodule MyList do
#   # def test([x, y | tail]), do: x
#   # def test1([x, y | tail]), do: y
#   # def test2([x, y | tail]), do: tail
#
#   def flatten([]) do
#     IO.puts "Empty list"
#     []
#   end
#
#   # def flatten([x, [head | tail]]) do
#   #   [x | [head | flatten(tail)]]
#   # end
#
#   # def flatten([head | tail]) do
#   #   flatten([tail | head])
#   # end
#   #
#   # def flatten([[head | tail] | tail]) do
#   # end
#
#   # def flatten([[head | tail] | []]) do
#   #   IO.puts "\nWorking with #{inspect([head | tail])}"
#   #   IO.puts "Head here is a list and tail is an empty list"
#   #   [head | flatten(tail)]
#   # end
#   #
#   # def flatten([[head | tail] | outer_tail]) do
#   #   IO.puts "\nWorking with #{inspect([[head | tail] | outer_tail])}"
#   #   IO.puts "Head is #{head}, tail is #{inspect(tail)}, and outer_tail is #{inspect(outer_tail)}"
#   #   [flatten([head | tail]) | flatten(outer_tail)]
#   # end
#   #
#   # def flatten([head | tail]) do
#   #   IO.puts "\nWorking with #{inspect([head | tail])}"
#   #   IO.puts "Head: #{head} | Tail: #{inspect(tail)}"
#   #   [head | flatten(tail)]
#   # end
#
#   # def flatten([[subHead | subTail] | tail]) do
#   #   IO.puts "Head is now a list: #{[subHead | subTail]}"
#   #   IO.puts "Tail is: #{tail}"
#   #   [flatten([subHead | subTail]) | flatten(tail)]
#   # end
#   #
#   # def flatten([head | tail]) do
#   # end
#
#   # def flatten([x | []]) do
#   #   IO.puts "Second element is an empty list"
#   #   [x]
#   # end
#
#   # def flatten([x, [head | tail], tail2]) do
#   #   [x | [head | flatten(tail), flatten(tail2)]]
#   # end
#
#   # def flatten([head | tail]), do
#
#   def flatten([head | tail]) do
#     IO.puts "Simple head and tail"
#     [head | flatten(tail)]
#   end
# end
#
# # my_list = MyList.flatten([1, [2, 3, [4]], 5])
# # my_list = MyList.flatten([[2, 3], 5])
# # my_list = MyList.flatten([[2], 3])
# my_list = MyList.flatten([2, 3])
# IO.puts inspect([2 | [ 3 | [] ]])
# IO.puts inspect(my_list)
# # MyList.flatten([1, [2, 3, [4]], 5])
