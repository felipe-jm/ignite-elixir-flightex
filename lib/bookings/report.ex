defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def create(filename \\ "report.csv") do
    booking_list = build_bookings_list()

    File.write(filename, booking_list)
  end

  defp build_bookings_list() do
    BookingAgent.list_all()
    |> Map.values()
    |> Enum.map(fn booking -> booking_string(booking) end)
  end

  defp booking_string(%Booking{
         id_usuario: id_usuario,
         cidade_origem: cidade_origem,
         cidade_destino: cidade_destino,
         data_completa: data_completa
       }) do
    "#{id_usuario},#{cidade_origem},#{cidade_destino},#{data_completa}\n"
  end
end
