ExUnit.start

defmodule Day05_2 do
    use ExUnit.Case, async: true
    # Yes, it actually does take that long: just that slightly under 3 mins
    # To run the tests, remove the skip-tags
    @moduletag timeout: 3*60*1000

    @zeroes_to_begin 5
    @zeroes String.duplicate("0", @zeroes_to_begin)
    @passwd_length 8

    @tag :skip
    test "input1" do
      password = solve("abc")
      IO.puts "Password for \"abc\" is #{password}"
      assert password == "05ace8e3"
    end

    @tag :skip
    test "result" do
      password = solve("abbhdwsy")
      IO.puts "Password is #{password}"
      assert password == "424a0197"
    end

    def solve(input) do
      Stream.iterate(0, &(&1+1))
      |> Stream.map(&("#{input}#{&1}"))
      |> Stream.map(&hash/1)
      |> Stream.filter(&String.starts_with?(&1, @zeroes))
      |> Stream.map(&pos_and_char/1)
      |> Stream.filter(&(&1!=nil))
      |> Enum.reduce_while(%{}, &create_password/2)
      |> Enum.sort(&(elem(&1,0)<elem(&2,0)))
      |> Enum.map(&(elem(&1,1)))
      |> Enum.join
    end

    def hash(input) do
      :crypto.hash(:md5, input)
        |> Base.encode16
        |> String.downcase
    end

    defp pos_and_char(input) do
      case Integer.parse(String.at(input, @zeroes_to_begin)) do
        {pos, ""} when pos in 0..7 -> {pos, String.at(input, @zeroes_to_begin+1)}
        _ -> nil
      end
    end

    defp create_password({position, char}, map) do
      case length(Map.keys(map)) do
            @passwd_length ->
              {:halt, map}
            _ ->
              {:cont, Map.put_new(map, position, char)}
          end
    end
    defp create_password(_, map), do: {:cont, map}
end
