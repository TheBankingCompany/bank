defmodule Bank.Ach.SixthIatAddenda do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :sixth_iat_addenda)
    |> field!(:record_type_code, :M, "7", 1)
    |> field!(:addenda_type_code, :M, "15", 2)
    |> field!(:receiver_identification_number, :O, :alphameric, 15)
    |> field!(:receiver_street_address, :M, :alphameric, 35)
    |> field!(:reserved, :NA, :blank, 34)
    |> field!(:entry_detail_sequence_number, :M, :numeric, 7)
    |> Map.get(:record)
  end
end
