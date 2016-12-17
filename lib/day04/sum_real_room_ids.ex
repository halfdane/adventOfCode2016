defmodule Day04_1 do

  def solve(lines) do
    lines
    |> Enum.map(&to_parts/1)
    |> Enum.map(&to_checksum/1)
    |> Enum.filter(&same_checksum?/1)
    |> Enum.map(fn([sector, _, _]) -> sector end)
    |> Enum.reduce(0, &+/2)
  end

  defp to_parts(line) do
    [sector_and_checksum|parts] = line
      |> String.split("-")
      |> Enum.reverse
    [_, sector, checksum] = Regex.run(~r/(.*)\[(.*)\]/, sector_and_checksum)
    [String.to_integer(sector), checksum, Enum.reverse(parts)]
  end

  defp to_checksum([sector, checksum, parts]) do
    calculated_checksum = parts
      |> Enum.join
      |> String.codepoints
      |> Enum.sort
      |> Enum.chunk_by(&(&1))
      |> Enum.map(&({Enum.count(&1), &1}))
      |> Enum.sort(fn({cnt1,_}, {cnt2,_}) -> cnt1>=cnt2 end)
      |> Enum.slice(0..4)
      |> Enum.map(fn({_,[h|_]}) -> h end)
      |> Enum.join
    [sector, checksum, calculated_checksum]
  end

  defp same_checksum?([_, checksum, calculated_checksum]) do
    checksum == calculated_checksum
  end

  def read_file(filename) do
    case File.read("lib/day04/#{filename}") do
      {:ok, content} -> content |> String.trim |> String.split("\n")
      {:error, _} -> raise "Input file is missing"
    end
  end
end

ExUnit.start

defmodule Day04_1Test do

  use ExUnit.Case
  test "input1" do
    input = Day04_1.read_file("input_01.txt")
    assert Day04_1.solve(input) == 1514
  end

  test "result" do
    input = Day04_1.read_file("input.txt")
    assert Day04_1.solve(input) == 361724
  end

end
