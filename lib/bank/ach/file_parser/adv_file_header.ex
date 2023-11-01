defmodule Bank.Ach.FileParser.AdvFileHeader do
  import NimbleParsec
  import Bank.Ach.FileParser.Types
  import Bank.Ach.FileParser.Common

  @spec record() :: NimbleParsec.t()
  def record() do
    record_type_code("1")
    |> concat(priority_code())
    |> concat(immediate_destination())
    |> concat(immediate_origin())
    |> concat(file_creation_date())
    |> concat(file_creation_time())
    |> concat(file_id_modifier())
    |> concat(record_size())
    |> concat(blocking_factor())
    |> concat(format_code())
    |> concat(immediate_destination_name())
    |> concat(immediate_origin_name())
    |> concat(reference_code())
  end

  @spec priority_code() :: NimbleParsec.t()
  def priority_code() do
    chars(2)
    |> tag(:priority_code)
  end

  @spec immediate_destination() :: NimbleParsec.t()
  def immediate_destination() do
    routing_number()
    |> tag(:immediate_destination)
  end

  @spec immediate_origin() :: NimbleParsec.t()
  def immediate_origin() do
    routing_number()
    |> tag(:immediate_origin)
  end

  @spec file_creation_date() :: NimbleParsec.t()
  def file_creation_date() do
    yymmdd()
    |> tag(:file_creation_date)
  end

  @spec file_creation_time() :: NimbleParsec.t()
  def file_creation_time() do
    hhmm()
    |> tag(:file_creation_time)
  end

  @spec file_id_modifier() :: NimbleParsec.t()
  def file_id_modifier() do
    chars(1)
    |> tag(:file_id_modifier)
  end

  @spec record_size() :: NimbleParsec.t()
  def record_size() do
    chars(3)
    |> tag(:record_size)
  end

  @spec blocking_factor() :: NimbleParsec.t()
  def blocking_factor() do
    chars(2)
    |> tag(:blocking_factor)
  end

  @spec format_code() :: NimbleParsec.t()
  def format_code() do
    chars(1)
    |> tag(:format_code)
  end

  @spec immediate_destination_name() :: NimbleParsec.t()
  def immediate_destination_name() do
    institution_name()
    |> tag(:immediate_destination_name)
  end

  @spec immediate_origin_name() :: NimbleParsec.t()
  def immediate_origin_name() do
    institution_name()
    |> tag(:immediate_origin_name)
  end

  @spec reference_code() :: NimbleParsec.t()
  def reference_code() do
    chars(8)
    |> tag(:reference_code)
  end

  @spec routing_number() :: NimbleParsec.t()
  def routing_number() do
    chars(10)
  end

  @spec institution_name() :: NimbleParsec.t()
  def institution_name() do
    chars(23)
  end
end
