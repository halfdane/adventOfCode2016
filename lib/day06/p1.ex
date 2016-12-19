ExUnit.start

defmodule Day06_2 do
    use ExUnit.Case, async: true

    test "input1" do
      input = read_file("input_01.txt")
      result = solve(input)
      IO.puts "Result is #{result|>inspect}"
      assert result == "easter"
    end

    test "result" do
      input = read_file("input.txt")
            result = solve(input)
            IO.puts "Result is #{result}"
            assert result == "umejzgdw"
    end

    def solve(input) do
      input
        |> Enum.map(&String.codepoints/1)
        |> Enum.reduce(%{}, &collate/2)
        |> Enum.sort(&(elem(&1,0)<elem(&2,0)))
        |> Enum.map(&(count(elem(&1, 1))))
        |> Enum.map(&(Enum.at(&1, 0)))
        |> Enum.join()
    end

    defp collate(a_line, result) do
        a_line
            |> Stream.with_index(0)
            |> Enum.reduce(result, &count_char_at/2)
    end

    defp count_char_at({character, index}, result) do
      previous = Map.get(result, index, [])
      new_count = previous ++ [character]
      Map.put(result, index, new_count)
    end

    defp count(list) do
      list
      |> Enum.sort
      |> Enum.chunk_by(&(&1))
      |> Enum.sort(&(Enum.count(&1)>Enum.count(&2)))
      |> Enum.map(&(Enum.at(&1, 0)))
    end


  def read_file(filename) do
    case File.read("lib/day06/#{filename}") do
      {:ok, content} -> content |> String.trim |> String.split("\n")
      {:error, _} -> raise "Input file is missing"
    end
  end

end
