defmodule Sentences do
  def capitalize_sentences(a) do
    a
    |> String.split(". ")
    |> (Enum.map &(String.capitalize(&1)))
    |> Enum.join(". ")
  end
end

IO.puts Sentences.capitalize_sentences("oh. a DOG. woof. ")
