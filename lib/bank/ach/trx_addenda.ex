defmodule Bank.Ach.TrxAddenda do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :trx_addenda)
    |> field!(:record_type_code, :M, "7", 1)
    |> field!(:addenda_type_code, :M, "05", 2)
    |> field!(:payment_related_information, :O, :alphameric, 80)
    |> field!(:addenda_sequence_number, :M, :numeric, 4)
    |> field!(:entry_detail_sequence_number, :M, :numeric, 7)
    |> Map.get(:record)
  end
end
