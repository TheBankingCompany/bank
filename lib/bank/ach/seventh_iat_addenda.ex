defmodule Bank.Ach.SeventhIatAddenda do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :seventh_iat_addenda)
    |> field!(:record_type_code, :M, "7", 1)
    |> field!(:addenda_type_code, :M, "16", 2)
    |> field!(:receiver_city_state, :M, :alphameric, 35)
    |> field!(:receiver_country_and_postal_cd, :M, :alphameric, 35)
    |> field!(:reserved, :NA, :blank, 14)
    |> field!(:entry_detail_sequence_number, :M, :numeric, 7)
    |> Map.get(:record)
  end
end
