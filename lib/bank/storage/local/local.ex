defmodule Bank.Storage.Local do
  @behaviour Bank.StorageBehavior

  @impl Bank.StorageBehavior
  def save(key, data) do
    File.write(key, data)
  end

  @impl Bank.StorageBehavior
  def load(key) do
    File.read(key)
  end
end
