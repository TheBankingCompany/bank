defmodule Bank.Ach.FileParser.FileHeader do
  use Bank.Ach.FileParser.LineParser

  @impl Bank.Ach.FileParser.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :file_header)
    |> field!(:record_type_code, 1, "1")
    |> field!(:priority_code, 2, :numeric)
    |> field!(:immediate_destination, 10, :padded_routing_number)
    |> field!(:immediate_origin, 10, :padded_routing_number)
    |> field!(:file_creation_date, 6, :yyymmdd)
    |> field!(:file_creation_time, 4, :hhmm)
    |> field!(:file_id_modifier, 1, :upper_az_numeric_09)
    |> field!(:record_size, 3, "094")
    |> field!(:blocking_factor, 2, "10")
    |> field!(:format_code, 1, "1")
    |> field!(:immediate_destination_name, 23, :alphameric)
    |> field!(:immediate_origin_name, 23, :alphameric)
    |> field!(:reference_code, 8, :alphameric)
    |> Map.get(:record)
  end
end
