defmodule Flightex.Bookings.BookingTest do
  use ExUnit.Case

  alias Flightex.Bookings.Booking
  alias Flightex.Users.Agent, as: UserAgent

  import Flightex.Factory

  describe "build/2" do
    setup do
      UserAgent.start_link(%{})

      user = build(:user)

      {:ok, uuid} = UserAgent.save(user)

      {:ok, id_usuario: uuid}
    end

    test "when all params are valid, returns a booking", %{id_usuario: id_usuario} do
      response =
        Booking.build(
          "2015-01-23T23:50:07",
          "Cuiabá",
          "Londres",
          id_usuario
        )

      expected_response =
        {:ok,
         %Flightex.Bookings.Booking{
           cidade_destino: "Londres",
           cidade_origem: "Cuiabá",
           data_completa: "2015-01-23T23:50:07",
           id_usuario: id_usuario
         }}

      assert response == expected_response
    end
  end
end
