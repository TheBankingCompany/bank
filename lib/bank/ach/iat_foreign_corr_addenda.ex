defmodule Bank.Ach.IatForeignCorrAddenda do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :iat_foreign_corr_addenda)
    |> field!(:record_type_code, :M, "7", 1)
    |> field!(:addenda_type_code, :M, "18", 2)
    |> field!(:foreign_corr_bank_name, :M, :alphameric, 35)
    |> field!(:foreign_corr_bank_id_num_qualifier, :M, :alphameric, 2)
    |> field!(:foreign_corr_bank_id_number, :M, :alphameric, 34)
    |> field!(:foreign_corr_bank_branch_country_code, :M, :alphameric, 3)
    |> field!(:reserved, :NA, :blank, 6)
    |> field!(:addenda_sequence_number, :M, :numeric, 4)
    |> field!(:entry_detail_sequence_number, :M, :numeric, 7)
    |> Map.get(:record)
  end
end
