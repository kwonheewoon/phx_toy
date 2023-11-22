defmodule PhxToyWeb.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:account_id, :name, :authorities]}
  @primary_key {:id, :integer, autogenerate: false}
  schema "users" do
    field :account_id, :string
    field :name, :string
    field :delete_yn, :string, default: "N"
    has_many :authorities, PhxToyWeb.Authorities.Authority
    #, foreign_key: :user_id

    #timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    IO.inspect attrs
    user
    |> cast(attrs, [:account_id, :name, :delete_yn])
    |> validate_required([:account_id, :name, :delete_yn])
    |> validate_length(:account_id, max: 30)
    |> validate_length(:name, max: 25)
    |> validate_inclusion(:delete_yn, ["Y", "N"])
    |> cast_assoc(:authorities)
  end

  def update_changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :delete_yn])
    |> validate_required([:name])
  end

  def delete_changeset(user) do
    user
    |> cast(%{"delete_yn" => "Y"}, [:delete_yn])
    |> validate_required([:name])
    |> validate_inclusion(:delete_yn, ["Y", "N"])
  end
end
