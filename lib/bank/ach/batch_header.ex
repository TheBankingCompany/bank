defmodule Bank.Ach.BatchHeader do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :batch_header)
    |> field!(:record_type_code, 1, "5")
    |> field!(:service_class_code, 3, :numeric)
    |> field!(:company_name, 16, :alphameric)
    |> field!(:company_discretionary_data, 20, :alphameric)
    |> field!(:company_identification, 10, :alphameric)
    |> field!(:standard_entry_class_code, 3, :alphameric)
    |> field!(:company_entry_description, 10, :alphameric)
    |> field!(:company_descriptive_date, 6, :alphameric)
    |> field!(:effective_entry_date, 6, :yymmdd)
    |> field!(:settlement_date, 3, :numeric)
    |> field!(:originator_status_code, 1, :alphameric)
    |> field!(:originating_dfi_identification, 8, :routing_number)
    |> field!(:batch_number, 7, :numeric)
    |> Map.get(:record)
  end
end
