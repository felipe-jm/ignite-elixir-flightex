defmodule Flightex.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when all params are valid, saves the user" do
      params = %{
        cpf: "12312312312",
        name: "Felipe",
        email: "felipe@gmail.com"
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:ok, "User with cpf 12312312312 created or updated successfully"}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error" do
      params = %{
        cpf: 12_312_312_312,
        email: "felipe@gmail.com",
        name: "Felipe"
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
