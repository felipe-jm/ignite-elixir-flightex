defmodule Flightex.Users.AgentTest do
  use ExUnit.Case

  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  import Flightex.Factory

  describe "save/1" do
    test "saves the user" do
      UserAgent.start_link(%{})

      user = build(:user)

      assert {:ok, _uuid} = UserAgent.save(user)
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when the user is found, returns the user" do
      user = build(:user)

      {:ok, uuid} = UserAgent.save(user)

      response = UserAgent.get(uuid)

      expected_response =
        {:ok, %User{cpf: "12312312312", email: "felipe@gmail.com", name: "Felipe"}}

      assert response == expected_response
    end

    test "when the user is not found, returns an error" do
      response = UserAgent.get("00000000000")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
