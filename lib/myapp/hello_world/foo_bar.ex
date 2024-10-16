defmodule Myapp.HelloWorld.FooBar do
  use Myapp.Schema
  import Ecto.Changeset

  schema "foobar" do
    field :a, :string
    field :b, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(foo_bar, attrs) do
    foo_bar
    |> cast(attrs, [:a, :b])
    |> validate_required([:a, :b])
  end
end
