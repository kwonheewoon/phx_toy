defmodule PhxToyWeb.ResCode do
  @status_codes %{
    ok: {200, "OK"},
    not_found: {404, "Not Found"},
    internal_error: {500, "Internal Server Error"}
  }

  def status_code(key) do
    Map.get(@status_codes, key)
  end
end
