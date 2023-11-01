defmodule Bank.Ach.FileParser.AdvFileControl do
  import NimbleParsec
  import Bank.Ach.FileParser.Types
  import Bank.Ach.FileParser.Common

  @spec record() :: NimbleParsec.t()
  def record() do
    record_type_code("9")
    |> concat(batch_count())
    |> concat(block_count())
    |> concat(entry_addenda_count())
    |> concat(entry_hash())
    |> concat(total_debit_amount())
    |> concat(total_credit_amount())
    |> concat(reserved())
  end

  @spec batch_count() :: NimbleParsec.t()
  def batch_count() do
    chars(6)
    |> tag(:batch_count)
  end

  @spec block_count() :: NimbleParsec.t()
  def block_count() do
    chars(6)
    |> tag(:block_count)
  end

  @spec entry_addenda_count() :: NimbleParsec.t()
  def entry_addenda_count() do
    chars(8)
    |> tag(:entry_addenda_count)
  end

  @spec entry_hash() :: NimbleParsec.t()
  def entry_hash() do
    chars(10)
    |> tag(:entry_hash)
  end

  @spec total_debit_amount() :: NimbleParsec.t()
  def total_debit_amount() do
    chars(20)
    |> tag(:total_debit_amount)
  end

  @spec total_credit_amount() :: NimbleParsec.t()
  def total_credit_amount() do
    chars(20)
    |> tag(:total_credit_amount)
  end

  @spec reserved() :: NimbleParsec.t()
  def reserved() do
    chars(23)
    |> tag(:reserved)
  end
end
