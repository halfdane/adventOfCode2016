defmodule AdventOfCode2016Test do
  use ExUnit.Case
  doctest AdventOfCode2016

  test "next direction (turning right)" do
    assert AdventOfCode2016.Day01.next_dir(:s, "R") == :w
    assert AdventOfCode2016.Day01.next_dir(:n, "R") == :e
    assert AdventOfCode2016.Day01.next_dir(:w, "R") == :n
  end

  test "previous direction (turning left)" do
    assert AdventOfCode2016.Day01.next_dir(:s, "L") == :e
    assert AdventOfCode2016.Day01.next_dir(:n, "L") == :w
    assert AdventOfCode2016.Day01.next_dir(:w, "L") == :s
  end

  test "movement" do
    assert AdventOfCode2016.Day01.move(:s, 5, [0,0]) == [0,-5]
    assert AdventOfCode2016.Day01.move(:w, 2, [17,8]) == [15,8]
  end

  test "interpret a direction" do
    assert AdventOfCode2016.Day01.goto("R2", {:n, [0,0]}) == {:e, [2, 0]}
    assert AdventOfCode2016.Day01.goto("L5", {:s, [33,-10]}) == {:e, [38, -10]}
    assert AdventOfCode2016.Day01.goto("R3", {:w, [12,28]}) == {:n, [12, 31]}
  end

  test "01 first" do
    assert AdventOfCode2016.Day01.distance("R2, L3") == 5
  end

  test "01 second" do
     assert AdventOfCode2016.Day01.distance("R2, R2, R2") == 2
  end

  test "01 third" do
     assert AdventOfCode2016.Day01.distance("R5, L5, R5, R3") == 12
  end

  test "01 result a" do
    input_string = "L1, L5, R1, R3, L4, L5, R5, R1, L2, L2, L3, R4, L2, R3, R1, L2, R5, R3, L4, R4, L3, R3, R3, L2, R1, L3, R2, L1, R4, L2, R4, L4, R5, L3, R1, R1, L1, L3, L2, R1, R3, R2, L1, R4, L4, R2, L189, L4, R5, R3, L1, R47, R4, R1, R3, L3, L3, L2, R70, L1, R4, R185, R5, L4, L5, R4, L1, L4, R5, L3, R2, R3, L5, L3, R5, L1, R5, L4, R1, R2, L2, L5, L2, R4, L3, R5, R1, L5, L4, L3, R4, L3, L4, L1, L5, L5, R5, L5, L2, L1, L2, L4, L1, L2, R3, R1, R1, L2, L5, R2, L3, L5, L4, L2, L1, L2, R3, L1, L4, R3, R3, L2, R5, L1, L3, L3, L3, L5, R5, R1, R2, L3, L2, R4, R1, R1, R3, R4, R3, L3, R3, L5, R2, L2, R4, R5, L4, L3, L1, L5, L1, R1, R2, L1, R3, R4, R5, R2, R3, L2, L1, L5"
    assert AdventOfCode2016.Day01.distance(input_string) == 253
  end
end
