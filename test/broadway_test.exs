defmodule MyBroadwayTest do
  use ExUnit.Case, async: true

  setup do
    Tesla.Mock.mock_global(fn %{method: :get} ->
      %Tesla.Env{status: 200, body: "tesla"}
    end)

    name = :"Broadway#{System.unique_integer([:positive, :monotonic])}"

    {:ok, _} =
      MyBroadway.start_link(name: name)

    %{name: name}
  end

  test "test message", %{name: name} do
    ref = Broadway.test_message(name, 1)
    assert_receive {:ack, ^ref, success, failures}, 5_000
    assert [_] = success
    assert [] = failures
  end
end
