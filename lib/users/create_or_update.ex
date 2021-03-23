defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  def call(%{name: name, email: email, cpf: cpf}) do
    cpf
    |> User.build(email, name)
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}) do
    uuid = UUID.uuid4()

    UserAgent.save(user, uuid)

    {:ok, uuid}
  end

  defp save_user({:error, _reason} = error), do: error
end
