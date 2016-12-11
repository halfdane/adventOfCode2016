defmodule Day01_1 do

  def next_dir(last_dir, rot) do
    turns = %{"R" => [n: :e, e: :s, s: :w, w: :n], "L" => [n: :w, w: :s, s: :e, e: :n]}
    turns[rot][last_dir]
  end

  def move(:n, steps), do: [0, steps]
  def move(:s, steps), do: [0, -steps]
  def move(:e, steps), do: [steps, 0]
  def move(:w, steps), do: [-steps, 0]

  def split_rotation_and_steps("R"<>steps), do: {"R", String.to_integer(steps)}
  def split_rotation_and_steps("L"<>steps), do: {"L", String.to_integer(steps)}

  def walk(dir, steps, [x1,y1]) do
    [x_add, y_add] = move(dir, steps)
    [x1+x_add, y1+y_add]
  end

  def goto(rotation_and_steps, {dir, pos}) do
    {rotation, steps} = split_rotation_and_steps(rotation_and_steps)
    turn_to = next_dir(dir, rotation)
    next_pos = walk(turn_to, steps, pos)
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

ExUnit.start

defmodule Day01_1Test do
  use ExUnit.Case

    test "next direction (turning right)" do
      assert Day01_1.next_dir(:s, "R") == :w
      assert Day01_1.next_dir(:n, "R") == :e
      assert Day01_1.next_dir(:w, "R") == :n
    end

    test "previous direction (turning left)" do
      assert Day01_1.next_dir(:s, "L") == :e
      assert Day01_1.next_dir(:n, "L") == :w
      assert Day01_1.next_dir(:w, "L") == :s
    end

    test "movement" do
      assert Day01_1.walk(:s, 5, [0,0]) == [0,-5]
      assert Day01_1.walk(:w, 2, [17,8]) == [15,8]
    end

    test "interpret a direction" do
      {dir, position} = Day01_1.goto("R2", {:n, [0,0]})
      assert {dir, position} == {:e, [2, 0]}

      {dir, position} = Day01_1.goto("L5", {:s, [33,-10]})
      assert {dir, position} == {:e, [38, -10]}

      {dir, position} = Day01_1.goto("R3", {:w, [12,28]})
      assert {dir, position} == {:n, [12, 31]}
    end

    test "01 first" do
      assert Day01_1.distance("R2, L3") == 5
    end

    test "01 second" do
       assert Day01_1.distance("R2, R2, R2") == 2
    end

    test "01 third" do
       assert Day01_1.distance("R5, L5, R5, R3") == 12
    end

    test "01 result a and b" do
      input_string = "L1, L5, R1, R3, L4, L5, R5, R1, L2, L2, L3, R4, L2, R3, R1, L2, R5, R3, L4, R4, L3, R3, R3, L2, R1, L3, R2, L1, R4, L2, R4, L4, R5, L3, R1, R1, L1, L3, L2, R1, R3, R2, L1, R4, L4, R2, L189, L4, R5, R3, L1, R47, R4, R1, R3, L3, L3, L2, R70, L1, R4, R185, R5, L4, L5, R4, L1, L4, R5, L3, R2, R3, L5, L3, R5, L1, R5, L4, R1, R2, L2, L5, L2, R4, L3, R5, R1, L5, L4, L3, R4, L3, L4, L1, L5, L5, R5, L5, L2, L1, L2, L4, L1, L2, R3, R1, R1, L2, L5, R2, L3, L5, L4, L2, L1, L2, R3, L1, L4, R3, R3, L2, R5, L1, L3, L3, L3, L5, R5, R1, R2, L3, L2, R4, R1, R1, R3, R4, R3, L3, R3, L5, R2, L2, R4, R5, L4, L3, L1, L5, L1, R1, R2, L1, R3, R4, R5, R2, R3, L2, L1, L5"
      assert Day01_1.distance(input_string) == 253
    end
end
