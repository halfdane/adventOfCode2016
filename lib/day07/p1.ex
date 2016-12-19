ExUnit.start

defmodule Day07_1 do
    use ExUnit.Case, async: true

    test "input1" do
      input = read_file("input_01.txt")
      result = count(input)
      assert result == 1
    end
    test "input2" do
      input = read_file("input_02.txt")
      result = count(input)
      assert result == 0
    end
    test "input3" do
      input = read_file("input_03.txt")
      result = count(input)
      assert result == 0
    end
    test "input4" do
      input = read_file("input_04.txt")
      result = count(input)
      assert result == 1
    end
    test "result" do
        input = read_file("input.txt")
        result = count(input)
        IO.puts "Result is #{result}"
        assert result == 118
    end

    def count(input) do
      input
      |> Enum.map(&group/1)
      |> Enum.count(&supports_tls?/1)
    end

    defp group(string) do
        re = ~r/\[(.*?)\]/
        hypernet =
          Regex.scan(re, string)
          |> Enum.map(&Enum.at(&1, 1))

        regular =
          string
          |> String.split(re)

        {regular, hypernet}
    end

    defp supports_tls?({regular, hypernets}) do
        Enum.find(regular, &abba?/1) && !Enum.find(hypernets, &abba?/1)
      end

    defp abba?(input) do
        abba = ~r{(\w)((?!\1)\w)\2\1}
        String.match?(input, abba)
    end

  def read_file(filename) do
    case File.read("lib/day07/#{filename}") do
      {:ok, content} -> content |> String.trim |> String.split("\n")
      {:error, _} -> raise "Input file is missing."
    end
  end

end
