defmodule PhoenixRestFramework.EctoResource do
  defmacro __using__(opts) do
    repo = Keyword.fetch!(opts, :repo)
    schema = Keyword.fetch!(opts, :schema)

    quote do
      @behaviour PhoenixRestFramework.Resource

      @repo unquote(repo)
      @schema unquote(schema)

      def list do
        query()
        |> @repo.all()
      end

      def get(id) do
        query()
        |> @repo.get(id)
      end

      def create(attrs) do
        %@schema{}
        |> changeset(attrs)
        |> @repo.insert()
      end

      def update(%@schema{} = record, attrs) do
        record
        |> changeset(attrs)
        |> @repo.update()
      end

      def delete(record) do
        @repo.delete(record)
      end

      defdelegate changeset(record, attrs), to: @schema

      def query, do: @schema

      defoverridable list: 0, get: 1, create: 1, update: 2, delete: 1, changeset: 2, query: 0
    end
  end
end
