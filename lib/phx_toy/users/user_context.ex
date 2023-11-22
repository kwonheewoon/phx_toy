defmodule PhxToyWeb.Users.UserContext do
  alias PhxToyWeb.Users.User
  alias PhxT
  alias PhxToy.Repo
  alias PhxToyWeb.UserStruct.UserParam
  import Ecto.Query

  def create_user(attrs \\ %{}) do
    case count_user_by_account_id(attrs["account_id"]) do
      count when count <= 0 ->
        %User{}
        |> User.changeset(attrs)
        |> Repo.insert(returning: true)

      count ->
        {:error, %{code: :conflict, message: "Duplicate account_id"}}
    end
  end

  def update_user(attrs \\ %{}) do
    case find_user_by_user_id(attrs["user_id"]) do
      {:error, _reason} = error ->
        error

      {:ok, user} ->
        user
        |> User.update_changeset(attrs)
        |> Repo.update()
    end
  end

  def delete_user(attrs \\ %{}) do
    case find_user_by_user_id(attrs["user_id"]) do
      {:error, _reason} = error ->
        error

      {:ok, user} ->
        user
        |> User.delete_changeset()
        |> Repo.update()

        {:ok, %{code: :ok, message: "User Delete Success"}}
    end
  end

  def find_user_all() do
    users = from(u in User, where: u.delete_yn == "N")
    |> Repo.all
    |> Repo.preload(:authorities)

    users = Enum.map(users, fn user ->
      %{name: user.name, account_id: user.account_id, authorities: user.authorities}
    end)
  end

  def find_user_by_user_id_and_account_id(user_id, account_id) do
    from(u in User,
      where: u.id == ^user_id and u.account_id == ^account_id and u.delete_yn == "N",
      select: %{account_id: u.account_id, name: u.name}
    )
    |> Repo.one
  end

  def count_user_by_account_id(account_id) do
    from(u in User,
      where: u.account_id == ^account_id and u.delete_yn == "N",
      select: count(u.id)
    )
    |> Repo.one
  end

  def count_user_by_user_id_account_id(user_id, account_id) do
    from(u in User,
      where: u.id == ^user_id and u.account_id == ^account_id and u.delete_yn == "N",
      select: count(u.id)
    )
    |> Repo.one
  end

  def find_user_by_user_id(user_id) do
    Repo.get_by(User, id: user_id, delete_yn: "N")
    |> case do
      nil -> {:error, %{code: :not_found, message: "Not Found User"}}
      user ->
        user = Repo.preload(user, :authorities)
        {:ok, user}
    end
  end

end
