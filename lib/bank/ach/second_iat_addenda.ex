defmodule Bank.Ach.SecondIatAddenda do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :second_iat_addenda)
    |> field!(:record_type_code, :M, "7", 1)
    |> field!(:addenda_type_code, :M, "11", 2)
    |> field!(:originator_name, :M, :alphameric, 35)
    |> field!(:originator_street_address, :M, :alphameric, 35)
    |> field!(:reserved, :NA, :blank, 14)
    |> field!(:entry_detail_sequence_number, :M, :numeric, 7)
    |> Map.get(:record)
  end
end
