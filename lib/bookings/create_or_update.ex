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
    |> save_booking
  end

  defp save_booking({:ok, %Booking{} = booking}) do
    uuid = UUID.uuid4()

    BookingAgent.save(booking, uuid)

    {:ok, uuid}
  end

  defp save_booking({:error, _reason} = error), do: error

  defp format_date(date) do
    case NaiveDateTime.from_iso8601(date) do
      {:ok, formatted_date} -> formatted_date
      {:error, :invalid_format} -> "Invalid format date"
    end
  end
end
