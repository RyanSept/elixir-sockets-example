defmodule MyappWeb.FooBarControllerTest do
  use MyappWeb.ConnCase

  import Myapp.HelloWorldFixtures

  alias Myapp.HelloWorld.FooBar

  @create_attrs %{
    a: "some a",
    b: "some b"
  }
  @update_attrs %{
    a: "some updated a",
    b: "some updated b"
  }
  @invalid_attrs %{a: nil, b: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all foobar", %{conn: conn} do
      conn = get(conn, ~p"/api/foobar")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create foo_bar" do
    test "renders foo_bar when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/foobar", foo_bar: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/foobar/#{id}")

      assert %{
               "id" => ^id,
               "a" => "some a",
               "b" => "some b"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/foobar", foo_bar: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update foo_bar" do
    setup [:create_foo_bar]

    test "renders foo_bar when data is valid", %{conn: conn, foo_bar: %FooBar{id: id} = foo_bar} do
      conn = put(conn, ~p"/api/foobar/#{foo_bar}", foo_bar: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/foobar/#{id}")

      assert %{
               "id" => ^id,
               "a" => "some updated a",
               "b" => "some updated b"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, foo_bar: foo_bar} do
      conn = put(conn, ~p"/api/foobar/#{foo_bar}", foo_bar: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete foo_bar" do
    setup [:create_foo_bar]

    test "deletes chosen foo_bar", %{conn: conn, foo_bar: foo_bar} do
      conn = delete(conn, ~p"/api/foobar/#{f}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/foobar/#{foo_bar}")
      end
    end
  end

  defp create_foo_bar(_) do
    foo_bar = foo_bar_fixture()
    %{foo_bar: foo_bar}
  end
end
