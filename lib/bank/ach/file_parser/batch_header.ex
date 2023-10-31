defmodule Bank.Ach.FileParser.BatchHeader do
  import NimbleParsec
  import Bank.Ach.FileParser.Types
  import Bank.Ach.FileParser.Common

  @spec record() :: NimbleParsec.t()
  def record() do
    record_type_code("5")
    |> concat(service_class_code())
    |> concat(company_name())
    |> concat(company_discretionary_data())
    |> concat(company_identification())
    |> concat(standard_entry_class_code())
    |> concat(company_entry_description())
    |> concat(company_descriptive_date())
    |> concat(effective_entry_date())
    |> concat(settlement_date())
    |> concat(originator_status_code())
    |> concat(originating_dfi_identification())
    |> concat(batch_number())
  end

  @spec service_class_code() :: NimbleParsec.t()
  def service_class_code() do
    chars(3)
    |> tag(:service_class_code)
  end

  @spec company_name() :: NimbleParsec.t()
  def company_name() do
    chars(16)
    |> tag(:company_name)
  end

  @spec company_discretionary_data() :: NimbleParsec.t()
  def company_discretionary_data() do
    chars(20)
    |> tag(:company_discretionary_data)
  end

  @spec company_identification() :: NimbleParsec.t()
  def company_identification() do
    chars(10)
    |> tag(:company_identification)
  end

  @spec standard_entry_class_code() :: NimbleParsec.t()
  def standard_entry_class_code() do
    chars(3)
    |> tag(:standard_entry_class_code)
  end

  @spec company_entry_description() :: NimbleParsec.t()
  def company_entry_description() do
    chars(10)
    |> tag(:company_entry_description)
  end

  @spec company_descriptive_date() :: NimbleParsec.t()
  def company_descriptive_date() do
    chars(6)
    |> tag(:company_descriptive_date)
  end

  @spec effective_entry_date() :: NimbleParsec.t()
  def effective_entry_date() do
    yymmdd()
    |> tag(:effective_entry_date)
  end

  @spec settlement_date() :: NimbleParsec.t()
  def settlement_date() do
    chars(3)
    |> tag(:settlement_date)
  end

  @spec originator_status_code() :: NimbleParsec.t()
  def originator_status_code() do
    chars(1)
    |> tag(:originator_status_code)
  end

  @spec originating_dfi_identification() :: NimbleParsec.t()
  def originating_dfi_identification() do
    chars(8)
    |> tag(:originator_dfi_identification)
  end

  @spec batch_number() :: NimbleParsec.t()
  def batch_number() do
    chars(7)
    |> tag(:batch_number)
  end
end
