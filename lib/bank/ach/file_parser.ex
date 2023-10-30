defmodule Bank.Ach.FileParser do
  import NimbleParsec

  defmodule Types do
    @spec numeric([{:max, pos_integer()} | {:min, non_neg_integer()}] | pos_integer()) ::
            NimbleParsec.t()
    def numeric(length) do
      ascii_string([?0..?9], length)
    end

    @spec numeric_with_space([{:max, pos_integer()} | {:min, non_neg_integer()}] | pos_integer()) ::
            NimbleParsec.t()
    def numeric_with_space(length) do
      ascii_string([?0..?9, ?\s], length)
    end

    @spec capital_alpha_numeric(
            [{:max, pos_integer()} | {:min, non_neg_integer()}]
            | pos_integer()
          ) :: NimbleParsec.t()
    def capital_alpha_numeric(length) do
      ascii_string([?0..?9, ?A..?Z], length)
    end

    @spec alpha_numeric([{:max, pos_integer()} | {:min, non_neg_integer()}] | pos_integer()) ::
            NimbleParsec.t()
    def alpha_numeric(length) do
      ascii_string([?0..?9, ?A..?Z, ?a..?z], length)
    end

    @spec alpha_numeric_with_space(
            [{:max, pos_integer()} | {:min, non_neg_integer()}]
            | pos_integer()
          ) :: NimbleParsec.t()
    def alpha_numeric_with_space(length) do
      ascii_string([?0..?9, ?A..?Z, ?a..?z, ?\s], length)
    end

    @spec alpha_numeric_with_space_plus(
            [char() | {:not, char() | Range.t()} | Range.t()],
            [{:max, pos_integer()} | {:min, non_neg_integer()}] | pos_integer()
          ) :: NimbleParsec.t()
    def alpha_numeric_with_space_plus(extras, length) do
      ascii_string([?0..?9, ?A..?Z, ?a..?z, ?\s] ++ extras, length)
    end
  end

  defmodule Common do
    import Types

    @spec record_type_code(<<_::8>>) :: NimbleParsec.t()
    def record_type_code(code) when code in ["1", "5", "6", "7", "8", "9"] do
      string(code)
      |> tag(:record_type_code)
    end

    @spec yymmdd() :: NimbleParsec.t()
    def yymmdd() do
      numeric(2)
      |> concat(numeric(2))
      |> concat(numeric(2))
    end

    @spec hhmm() :: NimbleParsec.t()
    def hhmm() do
      numeric(2)
      |> concat(numeric(2))
    end
  end

  defmodule FileHeader do
    import Types
    import Common

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
      string("01")
      |> tag(:priority_code)
    end

    @spec immediate_destination() :: NimbleParsec.t()
    def immediate_destination() do
      padded_routing_number()
      |> tag(:immediate_destination)
    end

    @spec immediate_origin() :: NimbleParsec.t()
    def immediate_origin() do
      padded_routing_number()
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
      capital_alpha_numeric(1)
      |> tag(:file_id_modifier)
    end

    @spec record_size() :: NimbleParsec.t()
    def record_size() do
      string("094")
      |> tag(:record_size)
    end

    @spec blocking_factor() :: NimbleParsec.t()
    def blocking_factor() do
      string("10")
      |> tag(:blocking_factor)
    end

    @spec format_code() :: NimbleParsec.t()
    def format_code() do
      string("1")
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
      alpha_numeric_with_space(8)
      |> tag(:reference_code)
    end

    @spec padded_routing_number() :: NimbleParsec.t()
    def padded_routing_number() do
      ignore(string(" "))
      |> concat(routing_number())
    end

    @spec routing_number() :: NimbleParsec.t()
    def routing_number() do
      numeric(9)
    end

    @spec institution_name() :: NimbleParsec.t()
    def institution_name() do
      alpha_numeric_with_space(23)
    end
  end

  defmodule BatchHeader do
    import Types
    import Common

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
      choice([
        string("200"),
        string("220"),
        string("225")
      ])
      |> tag(:service_class_code)
    end

    @spec company_name() :: NimbleParsec.t()
    def company_name() do
      alpha_numeric_with_space_plus([?'], 16)
      |> tag(:company_name)
    end

    @spec company_discretionary_data() :: NimbleParsec.t()
    def company_discretionary_data() do
      alpha_numeric_with_space(20)
      |> tag(:company_discretionary_data)
    end

    @spec company_identification() :: NimbleParsec.t()
    def company_identification() do
      alpha_numeric_with_space(10)
      |> tag(:company_identification)
    end

    def standard_entry_class_code() do
      choice([
        string("ARC"),
        string("BOC"),
        string("CCD"),
        string("CIE"),
        string("CTX"),
        string("IAT"),
        string("POP"),
        string("POS"),
        string("PPD"),
        string("RCK"),
        string("TEL"),
        string("WEB")
      ])
      |> tag(:standard_entry_class_code)
    end

    @spec company_entry_description() :: NimbleParsec.t()
    def company_entry_description() do
      alpha_numeric_with_space(10)
      |> tag(:company_entry_description)
    end

    @spec company_descriptive_date() :: NimbleParsec.t()
    def company_descriptive_date() do
      alpha_numeric_with_space(6)
      |> tag(:company_descriptive_date)
    end

    @spec effective_entry_date() :: NimbleParsec.t()
    def effective_entry_date() do
      yymmdd()
      |> tag(:effective_entry_date)
    end

    @spec settlement_date() :: NimbleParsec.t()
    def settlement_date() do
      numeric_with_space(3)
      |> tag(:settlement_date)
    end

    @spec originator_status_code() :: NimbleParsec.t()
    def originator_status_code() do
      string("1")
      |> tag(:originator_status_code)
    end

    @spec originating_dfi_identification() :: NimbleParsec.t()
    def originating_dfi_identification() do
      routing_number_sans_check_digit()
      |> tag(:originator_dfi_identification)
    end

    @spec batch_number() :: NimbleParsec.t()
    def batch_number() do
      numeric(7)
      |> tag(:batch_number)
    end

    @spec routing_number_sans_check_digit() :: NimbleParsec.t()
    def routing_number_sans_check_digit() do
      numeric(8)
    end
  end

  defparsec(:file_header, FileHeader.record())
  defparsec(:batch_header, BatchHeader.record())
end
