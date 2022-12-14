defmodule Pento.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :description, :string
    field :name, :string
    field :sku, :integer
    field :unit_price, :float

    timestamps()
  end

  def changeset(product, %{:unit_price => _unit_price} = attrs) do
    %{:unit_price => old_price} = product

    product
    |> cast(attrs, [:unit_price])
    |> validate_required(:unit_price)
    |> validate_number(:unit_price, less_than: old_price)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> unique_constraint(:sku)
    |> validate_number(:unit_price, greater_than: 0.0)
  end
end
