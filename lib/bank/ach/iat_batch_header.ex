defmodule Bank.Ach.IatBatchHeader do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :iat_batch_header)
    |> field!(:record_type_code, 1, "5")
    |> field!(:service_class_code, 3, :numeric)
    |> field!(:iat_indicator, 16, :alphameric)
    |> field!(:foreign_exchange_indicator, 2, :alphameric)
    |> field!(:foreign_exchange_reference_indicator, 1, :numeric)
    |> field!(:foreign_exchange_reference, 15, :alphameric)
    |> field!(:iso_destination_country_code, 2, :alphameric)
    |> field!(:originator_identification, 10, :alphameric)
    |> field!(:standard_entry_class_code, 3, :alphameric)
    |> field!(:company_entry_description, 10, :alphameric)
    |> field!(:iso_originating_currency_code, 3, :alphameric)
    |> field!(:iso_destination_currency_code, 3, :alphameric)
    |> field!(:effective_entry_date, 6, :yymmdd)
    |> field!(:settlement_date, 3, :numeric)
    |> field!(:originator_status_code, 1, :alphameric)
    |> field!(:originating_dfi_identification, 8, :routing_number)
    |> field!(:batch_number, 7, :numeric)
    |> Map.get(:record)
  end
end
