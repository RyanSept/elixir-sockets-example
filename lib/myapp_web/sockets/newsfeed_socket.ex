defmodule Myapp.NewsfeedSocket do
  @behaviour Phoenix.Socket.Transport
  alias Myapp.Newsfeed

  import Plug.Conn

  def child_spec(_opts) do
    # We won't spawn any process, so let's ignore the child spec
    :ignore
  end

  def connect(state) do
    # Callback to retrieve relevant data from the connection.
    # The map contains options, params, transport and endpoint keys.
    validate_auth(state)
  end

  @doc """
  connect/1 has been ran and we now have a ws connection.
  We initialize the session here.
  """
  def init(state) do
    send(self(), :refresh_and_push_feed)
    {:ok, state}
  end

  def handle_in({text, _opts}, state) do
    {:reply, :ok, {:text, text}, state}
  end

  def handle_info(:refresh_and_push_feed, state) do
    feed = Jason.encode!(Newsfeed.get_feed())
    schedule_feed_refresh()
    {:push, {:text, feed}, state}
  end

  def handle_info(_, state) do
    {:ok, state}
  end

  def terminate(_reason, _state) do
    :ok
  end

  @doc """
  Schedule pushing of newsfeed every 10 seconds
  """
  def schedule_feed_refresh() do
    Process.send_after(self(), :refresh_and_push_feed, 10_000)
  end

  def handle_error(conn, error) do
    case error do
      :unauthorized ->
        conn
        |> send_resp(401, "Unauthorized")

      _ ->
        conn
        |> send_resp(500, "Internal Server Error")
    end
  end

  defp validate_auth(state) do
    headers = Enum.into(state[:connect_info][:x_headers] || [], %{})
    auth_token = headers["x-authorization"]

    case auth_token do
      "secret" ->
        {:ok, state}

      _ ->
        # {:error, :unauthorized}
        {:ok, state}
    end
  end
end
