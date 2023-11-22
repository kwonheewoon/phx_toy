defmodule PhxToyWeb.Authorities.Authority do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:name]}
  @primary_key {:id, :integer, autogenerate: false}
  schema "authorities" do
    belongs_to :user, PhxToyWeb.Users.User
    # , references: :id,
    #   type: :integer,
    #   foreign_key: :user_id
    field :name, :string
    field :delete_yn, :string, default: "N"

  end

  @doc false
  def changeset(authority, attrs) do
    authority
    |> cast(attrs, [:user_id, :name, :delete_yn])
    |> validate_required([:name, :delete_yn])
    |> validate_inclusion(:delete_yn, ["Y", "N"])
  end

end
