defmodule Bank.Ach.FileParser.BocEntry do
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

  def transaction_code() do
    chars(2)
    |> tag(:transaction_code)
  end

  def receiving_dfi_identification() do
    chars(8)
    |> tag(:receiving_dfi_identification)
  end

  def check_digit() do
    chars(1)
    |> tag(:check_digit)
  end

  def dfi_account_number() do
    chars(17)
    |> tag(:dfi_account_number)
  end

  def amount() do
    chars(10)
    |> tag(:amount)
  end

  def check_serial_number() do
    chars(15)
    |> tag(:check_serial_number)
  end

  def receiver_name() do
    chars(22)
    |> tag(:receiver_name)
  end

  def discretionary_data() do
    chars(2)
    |> tag(:discretionary_data)
  end

  def addenda_record_indicator() do
    chars(1)
    |> tag(:addenda_record_indicator)
  end

  def trace_number() do
    chars(15)
    |> tag(:trace_number)
  end
end