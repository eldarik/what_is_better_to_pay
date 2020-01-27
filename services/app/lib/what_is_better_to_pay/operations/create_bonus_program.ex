defmodule WhatIsBetterToPay.Operations.CreateBonusProgram do
  import Map, only: [merge: 2]
  alias WhatIsBetterToPay.{Repo, Category, Place, BonusProgram}

  def execute(%{category: "*"} = params) do
    create_multipurpose(params)
    {:ok}
  end

  def execute(%{place: "*"} = params) do
    create_multipurpose(params)
    {:ok}
  end

  def execute(
    %{
      category: category_title,
      place: place_title
    } = params
  ) do
    category = find_or_create_category(category_title)
    place = find_or_create_place(place_title, category)
    merge(
      params,
      %{category: category.id, place: place.id, multipurpose: false}
    )
    |> create
    {:ok}
  end

  defp create_multipurpose(params) do
    merge(params, %{multipurpose: true})
    |> create
  end

  defp find_or_create_category(title) do
    category = Category |> Repo.get_by(title: title)
    case category do
      nil ->
        {:ok, category} =
          %Category{}
          |> Category.changeset(%{title: title})
          |> Repo.insert()
        category
      _ ->
        category
    end
  end

  defp find_or_create_place("-", _category),do: %Place{}

  defp find_or_create_place(title, category) do
    place = Place |> Repo.get_by(category_id: category.id, title: title)
    case place do
      nil ->
        {:ok, place} =
          %Place{}
          |> Place.changeset(%{title: title, category_id: category.id})
          |> Repo.insert()
        place
      _ ->
        place
    end
  end

  defp create(%{user: user} = params) do
    attrs = merge(params, %{state: "active", user_id: user.id})
    %BonusProgram{}
    |> BonusProgram.changeset(attrs)
    |> Repo.insert()
  end
end
