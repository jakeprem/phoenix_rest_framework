defmodule PhoenixRestFramework.Controller do
  @type conn :: Plug.Conn.t()
  @type params :: map()
  @type data :: struct() | map() | list()

  @callback index(conn, params) :: Plug.Conn.t()
  @callback show(conn, params) :: Plug.Conn.t()
  @callback create(conn, params) :: Plug.Conn.t()
  @callback update(conn, params) :: Plug.Conn.t()
  @callback delete(conn, params) :: Plug.Conn.t()

  @callback serialize(conn, data) :: map()
end
