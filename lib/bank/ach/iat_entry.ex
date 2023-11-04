defmodule Bank.Ach.IatEntry do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :iat_entry)
    |> field!(:record_type_code, :M, "6", 1)
    |> field!(:transaction_code, :M, :numeric, 2)
    |> field!(:receiving_dfi_identification, :M, :routing_number, 8)
    |> field!(:check_digit, :M, :numeric, 1)
    |> field!(:number_of_addenda_records, :M, :numeric, 4)
    |> field!(:reserved, :NA, :blank, 13)
    |> field!(:amount, :M, :amount_in_cents, 10)
    |> field!(:dfi_account_number, :M, :alphameric, 35)
    |> field!(:reserved, :NA, :blank, 2)
    |> field!(:gateway_operator_ofac_ind, :O, :alphameric, 1)
    |> field!(:secondary_ofac_indicator, :O, :alphameric, 1)
    |> field!(:addenda_record_indicator, :M, :numeric, 1)
    |> field!(:trace_number, :M, :numeric, 15)
    |> Map.get(:record)
  end
end
