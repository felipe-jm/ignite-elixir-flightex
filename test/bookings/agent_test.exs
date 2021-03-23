defmodule Flightex.Bookings.AgentTest do
  use ExUnit.Case

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking
  alias Flightex.Users.Agent, as: UserAgent

  import Flightex.Factory

  describe "save/1" do
    setup do
      user = build(:user)

      Flightex.start_agents()

      {:ok, uuid} = UserAgent.save(user)

      {:ok, id_usuario: uuid}
    end

    test "saves the booking", %{id_usuario: id_usuario} do
      booking = %Booking{
        data_completa: "2015-01-23T23:50:07",
        cidade_origem: "Cuiabá",
        cidade_destino: "Londres",
        id_usuario: id_usuario
      }

      assert {:ok, _uuid} = BookingAgent.save(booking)
    end
  end

  describe "get/1" do
    setup do
      user = build(:user)

      Flightex.start_agents()

      {:ok, uuid} = UserAgent.save(user)

      {:ok, id_usuario: uuid}
    end

    test "when the booking is found, returns the booking", %{id_usuario: id_usuario} do
      booking = %Booking{
        data_completa: "2015-01-23T23:50:07",
        cidade_origem: "Cuiabá",
        cidade_destino: "Londres",
        id_usuario: id_usuario
      }

      {:ok, uuid} = BookingAgent.save(booking)

      response = BookingAgent.get(uuid)

      expected_response = {:ok, booking}

      assert response == expected_response
    end

    test "when the order is not found, returns an error" do
      response = BookingAgent.get("invalid-id")

      expected_response = {:error, "Booking not found"}

      assert response == expected_response
    end
  end
end
