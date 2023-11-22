defmodule PhxToyWeb.UserController do
  use PhxToyWeb, :controller
  import PhxToyWeb.ResCode
  alias PhxToyWeb.Users.UserContext

  def create_user(conn, params) do
    case UserContext.create_user(params) do
      {:ok, user} ->
        IO.puts "create_user"
        IO.inspect user
        json(conn, %{result: user})
      {:error, response} ->
        conn
        |> put_status(response[:code])
        |> json(%{error: response})
    end
  end

  def update_user(conn, params) do
    case UserContext.update_user(params) do
      {:ok, user} ->
        json(conn, %{result: user})
      {:error, response} ->
        conn
        |> put_status(response[:code])
        |> json(%{error: response})
    end
  end

  def delete_user(conn, params) do
    case UserContext.delete_user(params) do
      {:ok, response} ->
        json(conn, response)
      {:error, response} ->
        conn
        |> put_status(response[:code])
        |> json(%{error: response})
    end
  end

  def find_user_all(conn, _params) do
    case UserContext.find_user_all() do
      users when is_list(users) ->
        json(conn, %{result: users})

      _error ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{error: "Unable to retrieve users"})
    end
  end

  @spec find_user_one(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def find_user_one(conn, %{"user_id" => user_id}) do
    case UserContext.find_user_by_user_id(user_id) do
      {:ok, user} ->
        json(conn, %{result: user})
      {:error, response} ->
        conn
        |> put_status(response[:code])
        |> json(%{error: response})
    end
  end
end
