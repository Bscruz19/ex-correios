defmodule ExCorreios.Shipping.Packages.Package do
  @moduledoc false

  @min_dimensions %{height: 2.0, length: 16.0, width: 11.0}

  alias ExCorreios.Shipping.Packages.{Format, PackageItem}

  @spec build(atom(), list()) :: map() | list(map)
  def build(format, items) when is_list(items) do
    dimension = calculate_dimensions(items)

    package = %{
      weight: sum(:weight, items),
      diameter: sum(:diameter, items),
      height: dimension,
      length: dimension,
      width: dimension
    }

    build_package(format, package)
  end

  @spec build(atom(), map()) :: map() | list(map)
  def build(format, item), do: build_package(format, item)

  defp build_package(format, package) do
    package
    |> Map.merge(dimensions(package))
    |> Map.put(:format, Format.get(format))
  end

  defp calculate_dimensions(items) do
    items
    |> Enum.reduce(0, fn item, acc -> PackageItem.volume(item) + acc end)
    |> :math.pow(1.0 / 3)
    |> Float.round(2)
  end

  defp sum(key, items), do: Enum.reduce(items, 0, fn item, acc -> Map.get(item, key) + acc end)

  defp dimensions(dimensions) do
    %{
      height: higher_value(dimensions.height, @min_dimensions.height),
      length: higher_value(dimensions.length, @min_dimensions.length),
      width: higher_value(dimensions.width, @min_dimensions.width)
    }
  end

  defp higher_value(value, min_value) when value > min_value, do: value
  defp higher_value(_value, min_value), do: min_value
end
