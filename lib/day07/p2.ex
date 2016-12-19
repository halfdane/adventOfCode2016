ExUnit.start

defmodule Day07_2 do
    use ExUnit.Case, async: true

    test "input1" do
      input = read_file("input_01a.txt")
      result = count(input)
      assert result == 1
    end
    test "input2" do
      input = read_file("input_02a.txt")
      result = count(input)
      assert result == 0
    end
    test "input3" do
      input = read_file("input_03a.txt")
      result = count(input)
      assert result == 1
    end
    test "input4" do
      input = read_file("input_04a.txt")
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
      |> Enum.count(&supports_ssl?/1)
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

    defp supports_ssl?({regular, hypernets}) do
        babs = regular
            |> Enum.flat_map(&get_abas/1)
            |> Enum.map(&to_bab/1)

        hypernets
            |> Enum.any?(&(contains?(&1, babs)))
  end

  defp contains?(hypernet, babs) do
        babs
            |> Enum.any?(&(String.contains?(hypernet, &1)))
  end

  defp get_abas(string), do: get_abas(string, [])
  defp get_abas(<<a, b, a, rest::binary>>, acc) when a != b, do: get_abas(<<b, a>> <> rest, [<<a, b, a>> | acc])
  defp get_abas(<<a, b, a>>, acc) when a != b, do: get_abas(<<b, a>>, [<<a, b, a>> | acc])
  defp get_abas(<<_, rest::binary>>, acc), do: get_abas(rest, acc)
  defp get_abas(<<_::binary>>, acc), do: acc

  defp to_bab(<<a, b, a>>), do: <<b, a, b>>



  def read_file(filename) do
    case File.read("lib/day07/#{filename}") do
      {:ok, content} -> content |> String.trim |> String.split("\n")
      {:error, _} -> raise "Input file is missing."
    end
  end

end
