defmodule Bank.Ach.FileParser.XckEntry do
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
    |> concat(process_control_field())
    |> concat(item_research_number())
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

  def process_control_field() do
    chars(6)
    |> tag(:process_control_field)
  end

  def item_research_number() do
    chars(16)
    |> tag(:item_research_number)
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
