defmodule MyappWeb.FooBarController do
  use MyappWeb, :controller

  alias Myapp.HelloWorld
  alias Myapp.HelloWorld.FooBar

  action_fallback MyappWeb.FallbackController

  def index(conn, _params) do
    foobar = HelloWorld.list_foobar()
    render(conn, :index, foobar: foobar)
  end

  def create(conn, %{"foo_bar" => foo_bar_params}) do
    with {:ok, %FooBar{} = foo_bar} <- HelloWorld.create_foo_bar(foo_bar_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/foobar/#{foo_bar}")
      |> render(:show, foo_bar: foo_bar)
    end
  end

  def show(conn, %{"id" => id}) do
    foo_bar = HelloWorld.get_foo_bar!(id)
    render(conn, :show, foo_bar: foo_bar)
  end

  def update(conn, %{"id" => id, "foo_bar" => foo_bar_params}) do
    foo_bar = HelloWorld.get_foo_bar!(id)

    with {:ok, %FooBar{} = foo_bar} <- HelloWorld.update_foo_bar(foo_bar, foo_bar_params) do
      render(conn, :show, foo_bar: foo_bar)
    end
  end

  def delete(conn, %{"id" => id}) do
    foo_bar = HelloWorld.get_foo_bar!(id)

    with {:ok, %FooBar{}} <- HelloWorld.delete_foo_bar(foo_bar) do
      send_resp(conn, :no_content, "")
    end
  end
end
