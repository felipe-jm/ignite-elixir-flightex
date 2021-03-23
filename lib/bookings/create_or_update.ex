defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking
  alias Flightex.Users.Agent, as: UserAgent

  def call(%{
        data_completa: data_completa,
        cidade_origem: cidade_origem,
        cidade_destino: cidade_destino,
        id_usuario: id_usuario
      }) do
    with {:ok, _user} <- UserAgent.get(id_usuario),
         {:ok, formatted_date} <- format_date(data_completa),
         {:ok, booking} <-
           Booking.build(formatted_date, cidade_origem, cidade_destino, id_usuario) do
      BookingAgent.save(booking)
    else
      error -> error
    end
  end

  defp format_date(date) do
    case NaiveDateTime.from_iso8601(date) do
      {:ok, formatted_date} -> {:ok, formatted_date}
      {:error, :invalid_format} -> "Invalid format date"
    end
  end
end
