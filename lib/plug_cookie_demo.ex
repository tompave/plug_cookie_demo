defmodule PlugCookieDemo do
  import Plug.Conn

  def start_server do
    {:ok, _} = Plug.Adapters.Cowboy.http __MODULE__, []
  end


  def init(opts), do: opts

  @cookie_conf_keys ~w(domain max_age path http_only secure expires)

  def call(conn, _opts) do
    conn
    |> add_response_cookies
    |> send_resp(200, "Hello World")
  end

  defp add_response_cookies(conn) do
    conn
    |> put_resp_cookie("foo", "simpleValue")
    |> put_resp_cookie("bar", "withSomeConfig", [http_only: false, max_age: 100])
    |> put_resp_cookie("qwe", "ignoredConfig", [expires: "Tue, 17 Oct 2017 02:24:24 GMT"])
  end
end
