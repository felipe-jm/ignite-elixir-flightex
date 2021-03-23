defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def call(%{
        data_completa: data_completa,
        cidade_origem: cidade_origem,
        cidade_destino: cidade_destino,
        id_usuario: id_usuario
      }) do
    data_completa
    |> format_date()
    |> Booking.build(cidade_origem, cidade_destino, id_usuario)
    |> BookingAgent.save()
  end

  defp format_date(date) do
    case NaiveDateTime.from_iso8601(date) do
      {:ok, formatted_date} -> formatted_date
      {:error, :invalid_format} -> "Invalid format date"
    end
  end
end
