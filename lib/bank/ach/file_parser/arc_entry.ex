defmodule Bank.Ach.FileParser.ArcEntry do
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
    |> concat(check_serial_number())
    |> concat(receiver_name())
    |> concat(discretionary_data())
    |> concat(addenda_record_indicator())
    |> concat(trace_number())
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
    chars(17)
    |> tag(:dfi_account_number)
  end

  @spec amount() :: NimbleParsec.t()
  def amount() do
    chars(10)
    |> tag(:amount)
  end

  @spec check_serial_number() :: NimbleParsec.t()
  def check_serial_number() do
    chars(15)
    |> tag(:check_serial_number)
  end

  @spec receiver_name() :: NimbleParsec.t()
  def receiver_name() do
    chars(22)
    |> tag(:receiver_name)
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

  @spec trace_number() :: NimbleParsec.t()
  def trace_number() do
    chars(15)
    |> tag(:trace_number)
  end
end
