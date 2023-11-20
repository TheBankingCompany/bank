defmodule Bank.StorageBehavior do
  @callback save(key :: String.t(), data :: any()) :: :ok | {:error, term()}
  @callback load(key :: String.t()) :: {:ok, any()} | {:error, term()}
end
