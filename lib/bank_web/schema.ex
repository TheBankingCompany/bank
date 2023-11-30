defmodule BankWeb.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(BankWeb.Schema.AchTypes)

  alias BankWeb.Resolvers

  query do
    @desc "Get an ach file"
    field :get_ach, :ach do
      arg(:id, non_null(:id))
      resolve(fn _, _, _ -> {:error, :not_implemented} end)
    end
  end

  mutation do
    @desc "Save an ach file"
    field :save_ach, :ach do
      arg(:request_id, non_null(:id))
      arg(:file_content, non_null(:string))

      resolve(&Resolvers.SaveAch.handle/3)
    end
  end
end
