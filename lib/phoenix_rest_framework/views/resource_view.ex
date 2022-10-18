defmodule PhoenixRestFramework.ResourceView do
  use Phoenix.View, root: "lib/phoenix_rest_framework/templates"

  def render("generic.json", %{data: data, fields: fields}) when is_list(data), do: render("index.json", records: data, fields: fields)
  def render("generic.json", %{data: data, fields: fields}), do: render("show.json", record: data, fields: fields)

  def render("index.json", %{records: records, fields: fields}) do
    %{
      data: render_many(records, __MODULE__, "resource.json", fields: fields, as: :resource)
    }
  end

  def render("show.json", %{record: record, fields: fields}) do
    %{data: render_one(record, __MODULE__, "resource.json", fields: fields, as: :resource)}
  end

  def render("resource.json", %{resource: resource, fields: fields}) do
    Map.take(resource, fields)
  end
end
