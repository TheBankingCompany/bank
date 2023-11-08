defmodule Bank.Ach.FirstIatAddenda do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :first_iat_addenda)
    |> field!(:record_type_code, :M, "7", 1)
    |> field!(:addenda_type_code, :M, "10", 2)
    |> field!(:transaction_type_code, :R, :alphameric, 3)
    |> field!(:foreign_payment_amount, :R, :amount_in_cents, 18)
    |> field!(:foreign_trace_number, :O, :alphameric, 22)
    |> field!(:receiving_company_name, :M, :alphameric, 35)
    |> field!(:reserved, :NA, :blank, 6)
    |> field!(:entry_detail_sequence_number, :M, :numeric, 7)
    |> Map.get(:record)
  end
end
