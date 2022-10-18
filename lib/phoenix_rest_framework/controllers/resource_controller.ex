defmodule PhoenixRestFramework.ResourceController do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts], location: :keep do
      use Phoenix.Controller, put_default_views: false
      @behaviour PhoenixRestFramework.Controller

      @resource Keyword.fetch!(opts, :resource)
      @fields Keyword.fetch!(opts, :fields)

      plug(:put_new_view, Keyword.get(opts, :view, PhoenixRestFramework.ResourceView))

      def serialize(conn, data) do
        vm = view_module(conn)
        Phoenix.View.render(vm, "generic.json", data: data, fields: @fields)
      end

      defp render_serialized(conn, data) do
        seralized_data = serialize(conn, data)
        json(conn, seralized_data)
      end

      def index(conn, _params) do
        render_serialized(conn, @resource.list())
      end

      def show(conn, %{"id" => id}) do
        case @resource.get(id) do
          nil -> {:error, :not_found}
          record -> render_serialized(conn, record)
        end
      end

      def create(conn, params) do
        with {:ok, record} <- @resource.create(params) do
          conn
          |> put_status(:created)
          |> render_serialized(record)
        end
      end

      def update(conn, %{"id" => id} = params) do
        with %{} = record <- @resource.get(id),
             {:ok, updated_record} <- @resource.update(record, params) do
          render_serialized(conn, updated_record)
        end
      end

      def delete(conn, params) do
        json(conn, %{error: "not implemented"})
      end

      defoverridable serialize: 2, index: 2, show: 2, create: 2, update: 2, delete: 2
    end
  end
end
