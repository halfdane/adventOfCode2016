ExUnit.start

defmodule Day05_1 do

    def solve(input) do
      zeroes_to_begin = 5
      zeroes = String.duplicate("0", zeroes_to_begin)

      Stream.iterate(0, &(&1+1))
      |> Stream.map(&("#{input}#{&1}"))
      |> Stream.map(&hash/1)
      |> Stream.filter(&String.starts_with?(&1, zeroes))
      |> Stream.map(&String.at(&1, zeroes_to_begin))
      |> Enum.take(8)
      |> Enum.join
    end

    def hash(input) do
      :crypto.hash(:md5, input)
        |> Base.encode16
        |> String.downcase
    end


  use ExUnit.Case

  test "input1" do
    #assert solve("abc") == "18f47a30"
  end

  test "result" do
    password = solve("abbhdwsy")
    IO.puts "Password is #{password}"
    assert password == "801b56a7"
  end

end
