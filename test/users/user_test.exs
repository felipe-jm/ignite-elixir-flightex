defmodule Flightex.Users.UserTest do
  use ExUnit.Case

  alias Flightex.Users.User

  import Flightex.Factory

  describe "build/5" do
    test "when all params are valid, returns the user" do
      response =
        User.build(
          "12312312312",
          "felipe@gmail.com",
          "Felipe"
        )

      expected_response = {:ok, build(:user)}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error" do
      response =
        User.build(
          12_312_312_312,
          "felipe@gmail.com",
          "Felipe"
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
