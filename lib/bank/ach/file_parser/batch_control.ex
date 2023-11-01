defmodule Bank.Ach.FileParser.BatchControl do
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
    |> concat(company_identification())
    |> concat(message_authentication_code())
    |> concat(reserved())
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
    chars(12)
    |> tag(:total_debit_amount)
  end

  @spec total_credit_amount() :: NimbleParsec.t()
  def total_credit_amount() do
    chars(12)
    |> tag(:total_credit_amount)
  end

  @spec company_identification() :: NimbleParsec.t()
  def company_identification() do
    chars(10)
    |> tag(:company_identification)
  end

  @spec message_authentication_code() :: NimbleParsec.t()
  def message_authentication_code() do
    chars(19)
    |> tag(:message_authentication_code)
  end

  @spec reserved() :: NimbleParsec.t()
  def reserved() do
    chars(6)
    |> tag(:reserved)
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
