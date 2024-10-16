defmodule Myapp.HelloWorld do
  @moduledoc """
  The HelloWorld context.
  """

  import Ecto.Query, warn: false
  alias Myapp.Repo

  alias Myapp.HelloWorld.FooBar

  @doc """
  Returns the list of foobar.

  ## Examples

      iex> list_foobar()
      [%FooBar{}, ...]

  """
  def list_foobar do
    Repo.all(FooBar)
  end

  @doc """
  Gets a single foo_bar.

  Raises `Ecto.NoResultsError` if the Foo bar does not exist.

  ## Examples

      iex> get_foo_bar!(123)
      %FooBar{}

      iex> get_foo_bar!(456)
      ** (Ecto.NoResultsError)

  """
  def get_foo_bar!(id), do: Repo.get!(FooBar, id)

  @doc """
  Creates a foo_bar.

  ## Examples

      iex> create_foo_bar(%{field: value})
      {:ok, %FooBar{}}

      iex> create_foo_bar(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_foo_bar(attrs \\ %{}) do
    %FooBar{}
    |> FooBar.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a foo_bar.

  ## Examples

      iex> update_foo_bar(foo_bar, %{field: new_value})
      {:ok, %FooBar{}}

      iex> update_foo_bar(foo_bar, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_foo_bar(%FooBar{} = foo_bar, attrs) do
    foo_bar
    |> FooBar.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a foo_bar.

  ## Examples

      iex> delete_foo_bar(foo_bar)
      {:ok, %FooBar{}}

      iex> delete_foo_bar(foo_bar)
      {:error, %Ecto.Changeset{}}

  """
  def delete_foo_bar(%FooBar{} = foo_bar) do
    Repo.delete(foo_bar)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking foo_bar changes.

  ## Examples

      iex> change_foo_bar(foo_bar)
      %Ecto.Changeset{data: %FooBar{}}

  """
  def change_foo_bar(%FooBar{} = foo_bar, attrs \\ %{}) do
    FooBar.changeset(foo_bar, attrs)
  end
end
