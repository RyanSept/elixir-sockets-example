defmodule Myapp.Newsfeed do
  @derive Jason.Encoder
  defstruct author: nil, body: nil, time: nil

  def get_feed(),
    do: [
      %__MODULE__{author: "user1", body: "It do be like that", time: ~U[2025-01-01 12:00:00Z]},
      %__MODULE__{author: "user2", body: "Covfefe again", time: ~U[2025-01-01 12:01:00Z]},
      %__MODULE__{author: "user3", body: "It's giving", time: ~U[2025-01-01 12:02:00Z]}
    ]
end
