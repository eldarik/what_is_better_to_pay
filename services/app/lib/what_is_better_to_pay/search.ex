defmodule WhatIsBetterToPay.Search do
  @moduledoc false

  import Ecto.Query

  def run(query, search_term) do
    # TODO: think about attributes arg
    # now used only title for Category and Place
    prefix_term = prefix_term(search_term)
    ilike_term = ilike_term(search_term)

    where(
      query,
      fragment(
        """
        to_tsvector('russian', title) @@ to_tsquery(?) or
        title ilike ?
        """,
        ^prefix_term,
        ^ilike_term
      )
    )
    |> order_by(
      fragment(
        "ts_rank(to_tsvector('russian', title), to_tsquery(?)) DESC",
        ^prefix_term
      )
    )
  end

  defp prefix_term(term) do
    String.replace(term, ~r/\W/u, "") <> ":*"
  end

  defp ilike_term(term) do
    "%#{term}%"
  end
end
