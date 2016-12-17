defmodule Day04_2 do

  def solve(lines) do
    lines
    |> Enum.map(&to_parts/1)
    |> Enum.filter(&same_checksum?/1)
    |> Enum.map(&decrypt/1)
    |> Enum.filter(&is_north_pole?/1)
    |> Enum.map(&(Enum.at(&1, 1)))
  end

  defp to_parts(line) do
    [sector_and_checksum|parts] = line
      |> String.split("-")
      |> Enum.reverse
    [_, room, sector, checksum] = Regex.run(~r/(.*)-(\d*)\[(.*)\]/, line)
    [room, String.to_integer(sector), checksum]
  end

  defp same_checksum?([room, _, checksum]) do
    calculated_checksum = room
      |> String.codepoints
      |> Enum.sort
      |> Enum.filter(&(&1!="-"))
      |> Enum.chunk_by(&(&1))
      |> Enum.map(&({Enum.count(&1), &1}))
      |> Enum.sort(fn({cnt1,_}, {cnt2,_}) -> cnt1>=cnt2 end)
      |> Enum.slice(0..4)
      |> Enum.map(fn({_,[h|_]}) -> h end)
      |> Enum.join

    checksum == calculated_checksum
  end

  def decrypt([room, sector, _]) do
    chars = String.codepoints("abcdefghijklmnopqrstuvwxyz")
    charmap = chars
      |> Stream.cycle
      |> Stream.drop(26 - rem(sector, 26))
      |> Enum.zip(chars)
      |> Map.new
      |> Map.put("-", " ")

    decrypted = room
      |> String.codepoints
      |> Enum.map(&Map.get(charmap, &1))
      |> Enum.join

    [decrypted, sector]
  end

  defp is_north_pole?([room, sector]) do
    String.contains?(room, "north")
  end


  def read_file(filename) do
    case File.read("lib/day04/#{filename}") do
      {:ok, content} -> content |> String.trim |> String.split("\n")
      {:error, _} -> raise "Input file is missing"
    end
  end
end

ExUnit.start

defmodule Day04_2Test do

  use ExUnit.Case

  test "direct" do
    assert Day04_2.decrypt(["qzmt-zixmtkozy-ivhz", 343, :ignore]) == "very encrypted name"
  end

  test "result" do
    input = Day04_2.read_file("input.txt")
    assert Day04_2.solve(input) == [482]
  end

end
