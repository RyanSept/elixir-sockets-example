defmodule Myapp.HelloWorldTest do
  use Myapp.DataCase

  alias Myapp.HelloWorld

  describe "foobar" do
    alias Myapp.HelloWorld.FooBar

    import Myapp.HelloWorldFixtures

    @invalid_attrs %{a: nil, b: nil}

    test "list_foobar/0 returns all foobar" do
      foo_bar = foo_bar_fixture()
      assert HelloWorld.list_foobar() == [foo_bar]
    end

    test "get_foo_bar!/1 returns the foo_bar with given id" do
      foo_bar = foo_bar_fixture()
      assert HelloWorld.get_foo_bar!(foo_bar.id) == foo_bar
    end

    test "create_foo_bar/1 with valid data creates a foo_bar" do
      valid_attrs = %{a: "some a", b: "some b"}

      assert {:ok, %FooBar{} = foo_bar} = HelloWorld.create_foo_bar(valid_attrs)
      assert foo_bar.a == "some a"
      assert foo_bar.b == "some b"
    end

    test "create_foo_bar/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HelloWorld.create_foo_bar(@invalid_attrs)
    end

    test "update_foo_bar/2 with valid data updates the foo_bar" do
      foo_bar = foo_bar_fixture()
      update_attrs = %{a: "some updated a", b: "some updated b"}

      assert {:ok, %FooBar{} = foo_bar} = HelloWorld.update_foo_bar(foo_bar, update_attrs)
      assert foo_bar.a == "some updated a"
      assert foo_bar.b == "some updated b"
    end

    test "update_foo_bar/2 with invalid data returns error changeset" do
      foo_bar = foo_bar_fixture()
      assert {:error, %Ecto.Changeset{}} = HelloWorld.update_foo_bar(foo_bar, @invalid_attrs)
      assert foo_bar == HelloWorld.get_foo_bar!(foo_bar.id)
    end

    test "delete_foo_bar/1 deletes the foo_bar" do
      foo_bar = foo_bar_fixture()
      assert {:ok, %FooBar{}} = HelloWorld.delete_foo_bar(foo_bar)
      assert_raise Ecto.NoResultsError, fn -> HelloWorld.get_foo_bar!(foo_bar.id) end
    end

    test "change_foo_bar/1 returns a foo_bar changeset" do
      foo_bar = foo_bar_fixture()
      assert %Ecto.Changeset{} = HelloWorld.change_foo_bar(foo_bar)
    end
  end
end
