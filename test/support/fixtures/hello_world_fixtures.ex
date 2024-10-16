defmodule Myapp.HelloWorldFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Myapp.HelloWorld` context.
  """

  @doc """
  Generate a foo_bar.
  """
  def foo_bar_fixture(attrs \\ %{}) do
    {:ok, foo_bar} =
      attrs
      |> Enum.into(%{
        a: "some a",
        b: "some b"
      })
      |> Myapp.HelloWorld.create_foo_bar()

    foo_bar
  end
end
