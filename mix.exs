defmodule PhoenixRestFramework.MixProject do
  use Mix.Project

  @project_url "https://github.com/jakeprem/phoenix_rest_framework"

  def project do
    [
      app: :phoenix_rest_framework,
      version: "0.2.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      name: "Phoenix Rest Framework",
      source_url: @project_url,
      homepage_url: @project_url,
      description: "Like Django Rest Framework, but for Phoenix"
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"Github" => @project_url}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:plug, "~> 1.13"},
      {:phoenix, "~> 1.6"}
    ]
  end
end
