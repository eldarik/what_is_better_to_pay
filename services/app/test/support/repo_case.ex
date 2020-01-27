defmodule WhatIsBetterToPay.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias WhatIsBetterToPay.Repo

      import Ecto
      import Ecto.Query
      import WhatIsBetterToPay.RepoCase
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
