defmodule Myapp.Repo.Migrations.CreateFoobar do
  use Ecto.Migration

  def change do
    create table(:foobar, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :a, :string
      add :b, :string

      timestamps(type: :utc_datetime)
    end
  end
end
