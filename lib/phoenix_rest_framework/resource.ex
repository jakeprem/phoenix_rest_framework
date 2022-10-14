defmodule PhoenixRestFramework.Resource do
  @type record :: struct() | map()

  @callback list() :: {:ok, records} when records: list

  @callback get(id :: any) :: {:ok, record}

  @callback create(attrs :: any) :: {:ok, record}

  @callback update(record, attrs :: any) :: {:ok, record}

  @callback delete(record) :: {:ok, record :: any}
end
