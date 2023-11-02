defmodule Bank.Ach.FileParser.FileHeader do
  use Bank.Ach.FileParser.LineParser

  @impl Bank.Ach.FileParser.LineParser
  def parse!(text, line_number, opts) do
    new!(text, line_number, opts)
    |> put(:record_type, :file_header)
    |> field!(:record_type_code, 1, :string)
    |> field!(:priority_code, 2, :string)
    |> field!(:immediate_destination, 10, :string)
    |> field!(:immediate_origin, 10, :string)
    |> field!(:file_creation_date, 6, :date)
    |> field!(:file_creation_time, 4, :time)
    |> field!(:file_id_modifier, 1, :string)
    |> field!(:record_size, 3, :integer)
    |> field!(:blocking_factor, 2, :integer)
    |> field!(:format_code, 1, :string)
    |> field!(:immediate_destination_name, 23, :string)
    |> field!(:immediate_origin_name, 23, :string)
    |> field!(:reference_code, 8, :string)
    |> Map.get(:record)
  end
end
