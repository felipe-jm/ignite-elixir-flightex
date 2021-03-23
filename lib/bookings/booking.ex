defmodule Flightex.Bookings.Booking do
  @keys [:data_completa, :cidade_origem, :cidade_destino, :id_usuario]

  @enforce_keys @keys

  defstruct @keys

  def build(data_completa, cidade_origem, cidade_destino, id_usuario) do
    {:ok,
     %__MODULE__{
       data_completa: data_completa,
       cidade_origem: cidade_origem,
       cidade_destino: cidade_destino,
       id_usuario: id_usuario
     }}
  end

  # def build(_data_completa, _cidade_origem, _cidade_destino, _id_usuario) do
  #   {:error, "Invalid parameters"}
  # end
end