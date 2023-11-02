defmodule Bank.Ach.FileParser.AdvEntry do
  import NimbleParsec
  import Bank.Ach.FileParser.Types
  import Bank.Ach.FileParser.Common

  @spec record() :: NimbleParsec.t()
  def record() do
    record_type_code("6")
    |> concat(transaction_code())
    |> concat(receiving_dfi_identification())
    |> concat(check_digit())
    |> concat(dfi_account_number())
    |> concat(amount())
    |> concat(advice_routing_number())
    |> concat(file_identification())
    |> concat(ach_operator_data())
    |> concat(individual_name())
    |> concat(discretionary_data())
    |> concat(addenda_record_indicator())
    |> concat(ach_operator_routing_number())
    |> concat(advice_creation_date())
    |> concat(batch_sequence_number())
  end

  @spec transaction_code() :: NimbleParsec.t()
  def transaction_code() do
    chars(2)
    |> tag(:transaction_code)
  end

  @spec receiving_dfi_identification() :: NimbleParsec.t()
  def receiving_dfi_identification() do
    chars(8)
    |> tag(:receiving_dfi_identification)
  end

  @spec check_digit() :: NimbleParsec.t()
  def check_digit() do
    chars(1)
    |> tag(:check_digit)
  end

  @spec dfi_account_number() :: NimbleParsec.t()
  def dfi_account_number() do
    chars(15)
    |> tag(:dfi_account_number)
  end

  @spec amount() :: NimbleParsec.t()
  def amount() do
    chars(12)
    |> tag(:amount)
  end

  @spec advice_routing_number() :: NimbleParsec.t()
  def advice_routing_number() do
    chars(9)
    |> tag(:advice_routing_number)
  end

  @spec file_identification() :: NimbleParsec.t()
  def file_identification() do
    chars(5)
    |> tag(:file_identification)
  end

  @spec ach_operator_data() :: NimbleParsec.t()
  def ach_operator_data() do
    chars(1)
    |> tag(:ach_operator_data)
  end

  @spec individual_name() :: NimbleParsec.t()
  def individual_name() do
    chars(22)
    |> tag(:individual_name)
  end

  @spec discretionary_data() :: NimbleParsec.t()
  def discretionary_data() do
    chars(2)
    |> tag(:discretionary_data)
  end

  @spec addenda_record_indicator() :: NimbleParsec.t()
  def addenda_record_indicator() do
    chars(1)
    |> tag(:addenda_record_indicator)
  end

  @spec ach_operator_routing_number() :: NimbleParsec.t()
  def ach_operator_routing_number() do
    chars(8)
    |> tag(:ach_operator_routing_number)
  end

  @spec advice_creation_date() :: NimbleParsec.t()
  def advice_creation_date() do
    chars(3)
    |> tag(:advice_creation_date)
  end

  @spec batch_sequence_number() :: NimbleParsec.t()
  def batch_sequence_number() do
    chars(4)
    |> tag(:batch_sequence_number)
  end
end
