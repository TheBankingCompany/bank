defmodule Bank.Ach.FifthIatAddenda do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :fifth_iat_addenda)
    |> field!(:record_type_code, :M, "7", 1)
    |> field!(:addenda_type_code, :M, "14", 2)
    |> field!(:receiving_dfi_name, :M, :alphameric, 35)
    |> field!(:receiving_dfi_id_number_qualifier, :M, :alphameric, 2)
    |> field!(:receiving_dfi_identification, :M, :alphameric, 34)
    |> field!(:receiving_dfi_branch_country_code, :M, :alphameric, 3)
    |> field!(:reserved, :NA, :blank, 10)
    |> field!(:entry_detail_sequence_number, :M, :numeric, 7)
    |> Map.get(:record)
  end
end
