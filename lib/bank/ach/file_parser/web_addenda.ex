defmodule Bank.Ach.FileParser.FileControl do
  import NimbleParsec
  import Bank.Ach.FileParser.Types
  import Bank.Ach.FileParser.Common

  @spec record() :: NimbleParsec.t()
  def record() do
    record_type_code("7")
    |> concat(addenda_type_code())
    |> concat(payment_related_info())
    |> concat(addenda_sequence_number())
    |> concat(entry_detail_sequence_number())
  end

  def addenda_type_code() do
    chars(2)
    |> tag(:addenda_type_code)
  end

  def payment_related_info() do
    chars(80)
    |> tag(:payment_related_info)
  end

  def addenda_sequence_number() do
    chars(4)
    |> tag(:addenda_sequence_number)
  end

  def entry_detail_sequence_number do
    chars(7)
    |> tag(:entry_detail_sequence_number)
  end
end
