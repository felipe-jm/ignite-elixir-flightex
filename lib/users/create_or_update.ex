defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  def call(%{name: name, email: email, cpf: cpf}) do
    cpf
    |> User.build(email, name)
    |> save_user()
  end

  defp save_user({:ok, %User{cpf: cpf} = user}) do
    UserAgent.save(user)

    {:ok, "User with cpf #{cpf} created or updated successfully"}
  end

  defp save_user({:error, _reason} = error), do: error
end
