defmodule Flightex.Users.User do
  @keys [:cpf, :email, :name]
  @enforce_keys @keys

  defstruct @keys

  def build(cpf, email, name) when is_bitstring(cpf) do
    {:ok,
     %__MODULE__{
       cpf: cpf,
       email: email,
       name: name
     }}
  end

  def build(_cpf, _email, _name), do: {:error, "Invalid parameters"}
end
