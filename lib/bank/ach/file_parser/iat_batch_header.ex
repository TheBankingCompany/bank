defmodule Bank.Ach.FileParser.IatBatchHeader do
  import NimbleParsec
  import Bank.Ach.FileParser.Types
  import Bank.Ach.FileParser.Common

  @spec record() :: NimbleParsec.t()
  def record() do
    record_type_code("5")
    |> concat(service_class_code())
    |> concat(iat_indicator())
    |> concat(foreign_exchange_indicator())
    |> concat(foreign_exchange_reference_indicator())
    |> concat(foreign_exchange_reference())
    |> concat(iso_destination_country_code())
    |> concat(originator_identification())
    |> concat(standard_entry_class_code())
    |> concat(company_entry_description())
    |> concat(iso_originating_currency_code())
    |> concat(iso_destination_currency_code())
    |> concat(effective_entry_date())
    |> concat(settlement_date())
    |> concat(originator_status_code())
    |> concat(originating_dfi_identification()) # GO Identification
    |> concat(batch_number())
  end

  @spec service_class_code() :: NimbleParsec.t()
  def service_class_code() do
    chars(3)
    |> tag(:service_class_code)
  end

  @spec iat_indicator() :: NimbleParsec.t()
  def iat_indicator() do
    chars(16)
    |> tag(:iat_indicator)
  end

  @spec foreign_exchange_indicator() :: NimbleParsec.t()
  def foreign_exchange_indicator() do
    chars(2)
    |> tag(:foreign_exchange_indicator)
  end

  @spec foreign_exchange_reference_indicator() :: NimbleParsec.t()
  def foreign_exchange_reference_indicator() do
    chars(1)
    |> tag(:foreign_exchange_reference_indicator)
  end

  @spec foreign_exchange_reference() :: NimbleParsec.t()
  def foreign_exchange_reference() do
    chars(15)
    |> tag(:foreign_exchange_reference)
  end

  @spec iso_destination_country_code() :: NimbleParsec.t()
  def iso_destination_country_code() do
    chars(2)
    |> tag(:iso_destination_country_code)
  end

  @spec originator_identification() :: NimbleParsec.t()
  def originator_identification() do
    chars(10)
    |> tag(:originator_identification)
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

  @spec iso_originating_currency_code() :: NimbleParsec.t()
  def iso_originating_currency_code() do
    chars(3)
    |> tag(:iso_originating_currency_code)
  end

  @spec iso_destination_currency_code() :: NimbleParsec.t()
  def iso_destination_currency_code() do
    chars(3)
    |> tag(:iso_destination_currency_code)
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
    |> tag(:originating_dfi_identification)
  end

  @spec batch_number() :: NimbleParsec.t()
  def batch_number() do
    chars(7)
    |> tag(:batch_number)
  end
end
