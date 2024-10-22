defmodule Myapp.NewsfeedSocket do
  @behaviour Phoenix.Socket.Transport

  def child_spec(_opts) do
    # We won't spawn any process, so let's ignore the child spec
    :ignore
  end

  def connect(state) do
    # Callback to retrieve relevant data from the connection.
    # The map contains options, params, transport and endpoint keys.
    validate_auth(state)
  end

  def init(state) do
    # Now we are effectively inside the process that maintains the socket.
    {:ok, state}
  end

  def handle_in({text, _opts}, state) do
    {:reply, :ok, {:text, text}, state}
  end

  def handle_info(_, state) do
    {:ok, state}
  end

  def terminate(_reason, _state) do
    :ok
  end

  defp validate_auth(state) do
    headers = Enum.into(state[:connect_info][:x_headers] || [], %{})
    auth_token = headers["x-authorization"]

    case auth_token do
      "secret" ->
        {:ok, state}

      _ ->
        # {:error, %{reason: "unauthorized"}}
        {:ok, state}
    end
  end
end
