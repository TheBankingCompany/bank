defmodule Bank.Ach.WebAddenda do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :web_addenda)
    |> field!(:record_type_code, 1, "7")
    |> field!(:addenda_type_code, 2, "05")
    |> field!(:payment_related_information, 80, :alphameric)
    |> field!(:addenda_sequence_number, 4, :numeric)
    |> field!(:entry_detail_sequence_number, 7, :numeric)
    |> Map.get(:record)
  end
end
