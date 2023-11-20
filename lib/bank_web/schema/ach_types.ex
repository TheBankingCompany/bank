defmodule BankWeb.Schema.AchTypes do
  use Absinthe.Schema.Notation

  @desc "An ach"
  object :ach do
    field :id, :id
  end
end
