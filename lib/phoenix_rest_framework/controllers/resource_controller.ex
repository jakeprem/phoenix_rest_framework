defmodule PhoenixRestFramework.ResourceController do
  defmacro __using__(opts) do
    resource = Keyword.fetch!(opts, :resource)
    fields = Keyword.fetch!(opts, :fields)

    quote do
      use Phoenix.Controller
      @behaviour PhoenixRestFramework.Controller

      @resource unquote(resource)
      @fields unquote(fields)

      def serialize(_conn, record) do
        Map.take(record, @fields)
      end

      def index(conn, _params) do
        serialized_data = @resource.list() |> Enum.map(&serialize(conn, &1))

        json(conn, %{data: serialized_data})
      end

      def show(conn, %{"id" => id}) do
        serialized_data = serialize(conn, @resource.get(id))

        json(conn, %{data: serialized_data})
      end

      def create(conn, params) do
        with {:ok, record} <- @resource.create(params) do
          serialized_data = serialize(conn, record)

          json(conn, %{data: serialized_data})
        else
          {:error, err} -> conn |> put_status(403) |> json(%{error: err})
        end
      end

      def update(conn, params) do
        json(conn, %{error: "not implemented"})
      end

      def delete(conn, params) do
        json(conn, %{error: "not implemented"})
      end

      defoverridable serialize: 2, index: 2, show: 2, create: 2, update: 2, delete: 2
    end
  end
end
