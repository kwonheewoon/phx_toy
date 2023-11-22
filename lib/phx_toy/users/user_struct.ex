defmodule PhxToyWeb.UserStruct.UserParam do

  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :user_id, :integer
    field :name, :string
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:user_id, :name])
    |> validate_required([:user_id, :name])
  end
end
