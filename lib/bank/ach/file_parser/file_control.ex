defmodule Bank.Ach.FileParser.FileControl do
  import NimbleParsec
  import Bank.Ach.FileParser.Types
  import Bank.Ach.FileParser.Common

  @spec record() :: NimbleParsec.t()
  def record() do
    record_type_code("9")
    |> concat(batch_count())
    |> concat(block_count())
    |> concat(entry_count())
    |> concat(entry_hash())
    |> concat(total_debit_amount())
    |> concat(total_credit_amount())
    |> concat(reserved())
  end

  def batch_count() do
    chars(6)
    |> tag(:batch_count)
  end

  def block_count() do
    chars(6)
    |> tag(:block_count)
  end

  def entry_count() do
    chars(8)
    |> tag(:entry_count)
  end

  def entry_hash() do
    chars(10)
    |> tag(:entry_hash)
  end

  def total_debit_amount() do
    chars(12)
    |> tag(:total_debit_amount)
  end

  def total_credit_amount() do
    chars(12)
    |> tag(:total_credit_amount)
  end

  def reserved() do
    chars(39)
    |> tag(:reserved)
  end
end
