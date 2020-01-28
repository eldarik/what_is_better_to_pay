defmodule WhatIsBetterToPay.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import WhatIsBetterToPay.Factory

      alias WhatIsBetterToPay.Repo
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(WhatIsBetterToPay.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(WhatIsBetterToPay.Repo, {:shared, self()})
    end

    :ok
  end
end
