defmodule MyappWeb.FooBarJSON do
  alias Myapp.HelloWorld.FooBar

  @doc """
  Renders a list of foobar.
  """
  def index(%{foobar: foobar}) do
    %{data: for(foo_bar <- foobar, do: data(foo_bar))}
  end

  @doc """
  Renders a single foo_bar.
  """
  def show(%{foo_bar: foo_bar}) do
    %{data: data(foo_bar)}
  end

  defp data(%FooBar{} = foo_bar) do
    %{
      id: foo_bar.id,
      a: foo_bar.a,
      b: foo_bar.b
    }
  end
end
