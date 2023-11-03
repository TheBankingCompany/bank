defmodule Bank.Ach.FileHeader do
  use Bank.Ach.LineParser

  @impl Bank.Ach.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :file_header)
    |> field!(:record_type_code, :M, "1", 1)
    |> field!(:priority_code, :R, :numeric, 2)
    |> field!(:immediate_destination, :M, :padded_routing_number, 10)
    |> field!(:immediate_origin, :M, :padded_routing_number, 10)
    |> field!(:file_creation_date, :M, :yymmdd, 6)
    |> field!(:file_creation_time, :O, :hhmm, 4)
    |> field!(:file_id_modifier, :M, :upper_az_numeric_09, 1)
    |> field!(:record_size, :M, "094", 3)
    |> field!(:blocking_factor, :M, "10", 2)
    |> field!(:format_code, :M, "1", 1)
    |> field!(:immediate_destination_name, :O, :alphameric, 23)
    |> field!(:immediate_origin_name, :O, :alphameric, 23)
    |> field!(:reference_code, :O, :alphameric, 8)
    |> Map.get(:record)
  end
end
