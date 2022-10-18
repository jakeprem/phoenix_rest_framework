defmodule PhoenixRestFramework.ResourceController do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts], location: :keep do
      use Phoenix.Controller, put_default_views: false
      @behaviour PhoenixRestFramework.Controller

      @resource Keyword.fetch!(opts, :resource)
      @fields Keyword.fetch!(opts, :fields)

      plug(:put_new_view, Keyword.get(opts, :view, PhoenixRestFramework.ResourceView))

      def index(conn, _params) do
        render(conn, :index, records: @resource.list(), fields: @fields)
      end

      def show(conn, %{"id" => id}) do
        case @resource.get(id) do
          nil -> {:error, :not_found}
          record -> render(conn, :show, record: record, fields: @fields)
        end
      end

      def create(conn, params) do
        with {:ok, record} <- @resource.create(params) do
          conn
          |> put_status(:created)
          |> render(:show, record: record)
        end
      end

      def update(conn, %{"id" => id} = params) do
        with %{} = record <- @resource.get(id),
             {:ok, updated_record} <- @resource.update(record, params) do
          render(conn, :show, record: updated_record, fields: @fields)
        end
      end

      def delete(conn, params) do
        json(conn, %{error: "not implemented"})
      end

      defoverridable index: 2, show: 2, create: 2, update: 2, delete: 2
    end
  end
end
