defmodule Flightex.Bookings.CreateOrUpdateTest do
  use ExUnit.Case

  alias Flightex.Bookings.CreateOrUpdate
  alias Flightex.Users.Agent, as: UserAgent

  import Flightex.Factory

  describe "call/1" do
    setup do
      user = build(:user)

      Flightex.start_agents()

      {:ok, uuid} = UserAgent.save(user)

      {:ok, id_usuario: uuid}
    end

    test "when all params are valid, saves the booking", %{
      id_usuario: id_usuario
    } do
      params = %{
        data_completa: "2015-01-23T23:50:07",
        cidade_origem: "Cuiabá",
        cidade_destino: "Londres",
        id_usuario: id_usuario
      }

      response = CreateOrUpdate.call(params)

      assert {:ok, _uuid} = response
    end

    test "when there is no user with given id, returns an error" do
      params = %{
        data_completa: "2015-01-23T23:50:07",
        cidade_origem: "Cuiabá",
        cidade_destino: "Londres",
        id_usuario: "invalid-id"
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
