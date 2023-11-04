defmodule Bank.Ach.ShrEntry do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :shr_entry)
    |> field!(:record_type_code, :M, "6", 1)
    |> field!(:transaction_code, :M, :numeric, 2)
    |> field!(:receiving_dfi_identification, :M, :routing_number, 8)
    |> field!(:check_digit, :M, :numeric, 1)
    |> field!(:dfi_account_number, :R, :alphameric, 17)
    |> field!(:amount, :M, :amount_in_cents, 10)
    |> field!(:card_expiration_date, :R, :mmyy, 4)
    |> field!(:document_reference_number, :R, :numeric, 11)
    |> field!(:individual_card_account_number, :R, :numeric, 22)
    |> field!(:card_transaction_type_code, :M, :numeric, 2)
    |> field!(:addenda_record_indicator, :M, :numeric, 1)
    |> field!(:trace_number, :M, :numeric, 15)
    |> Map.get(:record)
  end
end
