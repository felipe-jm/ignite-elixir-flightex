<h1 align="center">
    <img width="120" alt="Ignite" src="https://res.cloudinary.com/dqcqifjms/image/upload/v1615216700/felipejung/ignite.png" />
    <br>
    Ignite - Elixir - Flightex
</h1>

<h4 align="center">
  An app to manage fly bookings airplane
</h4>

## :information_source: How To Use

```bash
iex -S mix

# Create user params
iex(2)> user_params = %{name: "Felipe", email: "felipe@gmail.com", cpf: "12312312312"}
%{cpf: "12312312312", email: "felipe@gmail.com", name: "Felipe"}

# Start agents to save the states
iex(3)> Flightex.start_agents()
{:ok, #PID<0.277.0>}

# Create user
iex(4)> Flightex.create_or_update_user(user_params)
{:ok, "531ff715-2611-4d23-8fb6-49d275ef284c"}

# Create booking params
iex(5)> booking_params = %{data_completa: "2015-01-23T23:50:07", cidade_origem: "Cuiaba", cidade_destino: "Londres", id_usuario: "531ff715-2611-4d23-8fb6-49d275ef284c"}

# Create booking
iex(6)> Flightex.create_or_update_booking(booking_params)
{:ok, "defb06b2-a9a5-4902-bf5b-8073288db307"}

# Generate report
iex(6)> Flightex.Bookings.Report.create()
```

## :heavy_check_mark: Running the tests

```bash
mix test
..............

Finished in 0.1 seconds
14 tests, 0 failures

Randomized with seed 48836
```

## :memo: License

This project is under the MIT license. See the [LICENSE](https://github.com/felipe-jm/ignite-elixir-flightex/blob/master/LICENSE) for more information.

---

Made with much :heart: and :muscle: by Felipe Jung :blush: <a href="https://www.linkedin.com/in/felipe-jung/">Talk to me!</a>
