defmodule BankWeb.Resolvers.SaveAch do
  def handle(_parent, _request, _resolution) do
    # {:ok, _some_data} = Bank.Ach.LineParser.parse!(request.file_content)

    {:error, :not_implemented}
  end
end
