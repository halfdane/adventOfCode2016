defmodule Day03_1 do

  def possible_triangles(lines) do
    lines
    |> Enum.map(&to_chunks/1)
    |> Enum.map(&to_numberlist/1)
    |> Enum.map(&smallest_first/1)
    |> Enum.filter(&is_possible_triangle?/1)
    |> Enum.count
  end

  defp to_chunks(line) do
    line
    |> String.split()
  end

  defp to_numberlist([s1, s2, s3]) do
    [String.to_integer(s1), String.to_integer(s2), String.to_integer(s3)]
  end

  defp smallest_first(numbers) do
    Enum.sort(numbers)
  end

  defp is_possible_triangle?([n1, n2, n3]) do
    n1 + n2 > n3
  end

  def read_file(filename) do
    case File.read("lib/day03/#{filename}") do
      {:ok, content} -> content |> String.trim |> String.split("\n")
      {:error, _} -> raise "Input file is missing"
    end
  end
end

ExUnit.start

defmodule Day03_1Test do

  use ExUnit.Case
  test "input1" do
    input = Day03_1.read_file("input_01.txt")
    assert Day03_1.possible_triangles(input) == 0
  end

  test "input2" do
    input = Day03_1.read_file("input_02.txt")
    assert Day03_1.possible_triangles(input) == 5
  end

  test "result" do
    input = Day03_1.read_file("input.txt")
    assert Day03_1.possible_triangles(input) == 1032
  end

end
