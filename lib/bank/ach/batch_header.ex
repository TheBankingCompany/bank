defmodule Bank.Ach.BatchHeader do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :batch_header)
    |> field!(:record_type_code, :M, "5", 1)
    |> field!(:service_class_code, :M, :numeric, 3)
    |> field!(:company_name, :M, :alphameric, 16)
    |> field!(:company_discretionary_data, :O, :alphameric, 20)
    |> field!(:company_identification, :M, :alphameric, 10)
    |> field!(:standard_entry_class_code, :M, :alphameric, 3)
    |> field!(:company_entry_description, :M, :alphameric, 10)
    |> field!(:company_descriptive_date, :O, :alphameric, 6)
    |> field!(:effective_entry_date, :R, :yymmdd, 6)
    |> field!(:settlement_date, :ACH, :numeric, 3)
    |> field!(:originator_status_code, :M, :alphameric, 1)
    |> field!(:originating_dfi_identification, :M, :routing_number, 8)
    |> field!(:batch_number, :M, :numeric, 7)
    |> Map.get(:record)
  end
end
