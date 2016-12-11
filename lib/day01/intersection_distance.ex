defmodule Day01 do

  def distance(input_string) do
    input_string
      |> String.split(", ")
      |> Enum.map(&(parse(&1)))
      |> move({0,0},:n, MapSet.new |> MapSet.put({0,0}))
      |> measure
  end

  defp parse("R"<>steps), do: {:r, String.to_integer(steps)}
  defp parse("L"<>steps), do: {:l, String.to_integer(steps)}

  defp move([{lr, steps} | remainder], location, direction, seen) do
    new_direction = turn(lr, direction)
    case step(steps, location, new_direction, seen) do
      {:continue, new_location, new_seen} ->
          move(remainder, new_location, new_direction, new_seen)
      {:done, intersection} -> intersection
    end
  end
  defp move([], location, _direction, _seen), do: location

  def turn(:l, last_dir), do: Map.get(%{:n => :e, :e => :s, :s => :w, :w => :n}, last_dir)
  def turn(:r, last_dir), do: Map.get(%{:n => :w, :w => :s, :s => :e, :e => :n}, last_dir)

  defp step(0, location, _direction, seen), do: {:continue, location, seen}
  defp step(amount, location, direction, seen) do
    new_location = a_step(location, direction)
    if MapSet.member?(seen, new_location) do
      {:done, new_location}
    else
        new_seen = MapSet.put(seen, new_location)
        step(amount-1, new_location, direction, new_seen)
    end
  end

  defp a_step({x,y}, :n), do: {x, y+1}
  defp a_step({x,y}, :s), do: {x, y-1}
  defp a_step({x,y}, :e), do: {x+1, y}
  defp a_step({x,y}, :w), do: {x-1, y}

  defp measure({x,y}) do
    abs(x)+abs(y)
  end

end

ExUnit.start

defmodule Day01Test do
  use ExUnit.Case

    test "01 additional" do
       assert Day01.distance("R8, R4, R4, R8") == 4
    end

    test "01 result a and b" do
      input_string = "L1, L5, R1, R3, L4, L5, R5, R1, L2, L2, L3, R4, L2, R3, R1, L2, R5, R3, L4, R4, L3, R3, R3, L2, R1, L3, R2, L1, R4, L2, R4, L4, R5, L3, R1, R1, L1, L3, L2, R1, R3, R2, L1, R4, L4, R2, L189, L4, R5, R3, L1, R47, R4, R1, R3, L3, L3, L2, R70, L1, R4, R185, R5, L4, L5, R4, L1, L4, R5, L3, R2, R3, L5, L3, R5, L1, R5, L4, R1, R2, L2, L5, L2, R4, L3, R5, R1, L5, L4, L3, R4, L3, L4, L1, L5, L5, R5, L5, L2, L1, L2, L4, L1, L2, R3, R1, R1, L2, L5, R2, L3, L5, L4, L2, L1, L2, R3, L1, L4, R3, R3, L2, R5, L1, L3, L3, L3, L5, R5, R1, R2, L3, L2, R4, R1, R1, R3, R4, R3, L3, R3, L5, R2, L2, R4, R5, L4, L3, L1, L5, L1, R1, R2, L1, R3, R4, R5, R2, R3, L2, L1, L5"
      assert Day01.distance(input_string) == 126
    end
end
