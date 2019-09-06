defmodule ExCorreios.Shipping.ShippingTest do
  use ExUnit.Case

  import ExCorreios.Factory

  alias ExCorreios.Shipping.Shipping

  describe "Shipping.new/3" do
    test "returns a shipping struct" do
      package = build(:package)

      assert %Shipping{} =
               Shipping.new([:pac, :sedex], package, %{
                 destination: "06666666",
                 origin: "03333333"
               })
    end
  end
end
