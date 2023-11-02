defmodule Bank.Ach.FileParser.AdvBatchControl do
  import NimbleParsec
  import Bank.Ach.FileParser.Types
  import Bank.Ach.FileParser.Common

  @spec record() :: NimbleParsec.t()
  def record() do
    record_type_code("8")
    |> concat(service_class_code())
    |> concat(entry_addenda_count())
    |> concat(entry_hash())
    |> concat(total_debit_amount())
    |> concat(total_credit_amount())
    |> concat(ach_operator_data())
    |> concat(originating_dfi_identification())
    |> concat(batch_number())
  end

  @spec service_class_code() :: NimbleParsec.t()
  def service_class_code() do
    chars(3)
    |> tag(:service_class_code)
  end

  @spec entry_addenda_count() :: NimbleParsec.t()
  def entry_addenda_count() do
    chars(6)
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

  @spec ach_operator_data() :: NimbleParsec.t()
  def ach_operator_data() do
    chars(19)
    |> tag(:ach_operator_data)
  end

  @spec originating_dfi_identification() :: NimbleParsec.t()
  def originating_dfi_identification() do
    chars(8)
    |> tag(:originating_dfi_identification)
  end

  @spec batch_number() :: NimbleParsec.t()
  def batch_number() do
    chars(7)
    |> tag(:batch_number)
  end
end
