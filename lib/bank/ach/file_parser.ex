defmodule Bank.Ach.FileParser do
  import NimbleParsec

  defmodule FileHeader do
    def file_header() do
      record_type_code()
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

    def record_type_code() do
      string("1")
      |> tag(:record_type_code)
    end

    def priority_code() do
      string("01")
      |> tag(:priority_code)
    end

    def immediate_destination() do
      padded_routing_number()
      |> tag(:immediate_destination)
    end

    def immediate_origin() do
      padded_routing_number()
      |> tag(:immediate_origin)
    end

    def file_creation_date() do
      yymmdd()
      |> tag(:file_creation_date)
    end

    def file_creation_time() do
      hhmm()
      |> tag(:file_creation_time)
    end

    def file_id_modifier() do
      ascii_string([?0..?9, ?A..?Z], 1)
      |> tag(:file_id_modifier)
    end

    def record_size() do
      string("094")
      |> tag(:record_size)
    end

    def blocking_factor() do
      string("10")
      |> tag(:blocking_factor)
    end

    def format_code() do
      string("1")
      |> tag(:format_code)
    end

    def immediate_destination_name() do
      institution_name()
      |> tag(:immediate_destination_name)
    end

    def immediate_origin_name() do
      institution_name()
      |> tag(:immediate_origin_name)
    end

    def reference_code() do
      alpha_numeric_with_space(8)
      |> tag(:reference_code)
    end

    def padded_routing_number() do
      ignore(string(" "))
      |> concat(routing_number())
    end

    def routing_number() do
      ascii_string([?0..?9], 9)
    end

    def yymmdd() do
      ascii_string([?0..?9], 2)
      |> ascii_string([?0..?9], 2)
      |> ascii_string([?0..?9], 2)
    end

    def hhmm() do
      ascii_string([?0..?9], 2)
      |> ascii_string([?0..?9], 2)
    end

    def institution_name() do
      alpha_numeric_with_space(23)
    end

    def alpha_numeric_with_space(length) do
      ascii_string([?0..?9, ?a..?z, ?A..?Z, ?\s], length)
    end
  end

  defparsec(:file_header, FileHeader.file_header())
end
