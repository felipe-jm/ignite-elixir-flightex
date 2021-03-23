defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  def call(%{name: name, email: email, cpf: cpf}) do
    with {:ok, user} <- User.build(cpf, email, name) do
      UserAgent.save(user)
    else
      error -> error
    end
  end
end
