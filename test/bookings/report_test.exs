defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking
  alias Flightex.Bookings.Report
  alias Flightex.Users.Agent, as: UserAgent

  describe "create/1" do
    setup do
      user = build(:user)

      Flightex.start_agents()

      {:ok, uuid} = UserAgent.save(user)

      {:ok, id_usuario: uuid}
    end

    test "creates the report file", %{id_usuario: id_usuario} do
      BookingAgent.start_link(%{})

      booking1 = %Booking{
        data_completa: "2015-01-23T23:50:07",
        cidade_origem: "Cuiabá",
        cidade_destino: "Londres",
        id_usuario: id_usuario
      }

      BookingAgent.save(booking1)

      booking2 = %Booking{
        data_completa: "2019-01-23T23:50:07",
        cidade_origem: "Cuiabá",
        cidade_destino: "Tokyo",
        id_usuario: id_usuario
      }

      BookingAgent.save(booking2)

      expected_response =
        "#{id_usuario},Cuiabá,Tokyo,2019-01-23T23:50:07\n" <>
          "#{id_usuario},Cuiabá,Londres,2015-01-23T23:50:07\n"

      Report.create("report_test.csv")

      response = File.read!("report_test.csv")

      assert response == expected_response
    end
  end
end
