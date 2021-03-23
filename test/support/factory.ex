defmodule Flightex.Factory do
  use ExMachina

  alias Flightex.Users.User

  def user_factory do
    %User{
      name: "Felipe",
      email: "felipe@gmail.com",
      cpf: "12312312312"
    }
  end
end
