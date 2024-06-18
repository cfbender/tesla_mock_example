defmodule TeslaMockTest do
  use ExUnit.Case
  doctest TeslaMock

  test "greets the world" do
    assert TeslaMock.hello() == :world
  end
end
