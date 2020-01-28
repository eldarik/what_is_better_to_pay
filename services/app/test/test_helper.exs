ExUnit.start(timeout: 99_999_999)

ExUnit.configure(timeout: :infinity, exclude: [pending: true], trace: false)

Ecto.Adapters.SQL.Sandbox.mode(WhatIsBetterToPay.Repo, :manual)

{:ok, _} = Application.ensure_all_started(:ex_machina)
