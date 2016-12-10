defmodule AdventOfCode2016.Day01 do

  def rotation(dir) do
    case dir do
      "R"<>_ -> 1
      "L"<>_ -> -1
    end
  end

  def next_dir(last_dir, rot) do
    dirs = [ :n, :e, :s, :w ]
    last_index = Enum.find_index(dirs, fn(x) -> x == last_dir end)
    current_index = rem(last_index+rotation(rot), Enum.count(dirs))
    Enum.at(dirs, current_index)
  end

  def move(dir, steps) do
    case dir do
      :n -> [0, steps]
      :s -> [0, -steps]
      :e -> [steps, 0]
      :w -> [-steps, 0]
    end
  end

  def move(dir, steps, curren_pos) do
    [x1, y1] = curren_pos
    [x_add, y_add] = move(dir, steps)
    [x1+x_add, y1+y_add]
  end

  def asInt(numAsString) do
    {result, ""} = Integer.parse(numAsString)
    result
  end

  def m(dir) do
    case dir do
      "R"<>cnt -> {"R", asInt(cnt)}
      "L"<>cnt -> {"L", asInt(cnt)}
    end
  end

  def goto(rotation_and_steps, {dir, pos}) do
    {rotation, steps} = m(rotation_and_steps)
    turn_to = next_dir(dir, rotation)
    next_pos = move(turn_to, steps, pos)
    {turn_to, next_pos}
  end

  def goto(input_string) do
    String.split(input_string, ", ")
      |> Enum.reduce({:n, [0,0]}, &goto/2)
  end

  def distance(input_string) do
    {_, [x, y]} = goto(input_string)
    abs(x)+abs(y)
  end

end
