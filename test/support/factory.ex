defmodule ExCorreios.Factory do
  @moduledoc false

  use ExMachina

  alias ExCorreios.Calculator.Shipping
  alias ExCorreios.Calculator.Shipping.{Package, Service}

  def package_factory do
    %Package{diameter: 40, format: 1, width: 11.0, height: 2.0, length: 16.0, weight: 0.3}
  end

  def shipping_factory do
    %Shipping{
      declared_value: 0,
      destination: "05724005",
      enterprise: "",
      manually_entered: false,
      origin: "08720030",
      package: package_factory(),
      password: "",
      receiving_alert: false,
      service: Service.get_service(:pac)
    }
  end
end
