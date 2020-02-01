defmodule WhatIsBetterToPay.Operations.CreateBonusProgram do
  import Map, only: [merge: 2]
  import Ecto.Query, only: [from: 2]
  alias WhatIsBetterToPay.{Repo, Category, Place, BonusProgram, SimilarCategory}

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
      %{category: category, place: place, multipurpose: false}
    )
    |> create

    {:ok}
  end

  defp create_multipurpose(%{user: user} = params) do
    attrs =
      %{
        state: "active",
        user_id: user.id,
        multipurpose: true
      }
      |> merge(params)

    base_create(attrs)
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

  defp similar_categories(category) do
    from(
      c in Category,
      join: sc in SimilarCategory,
      on: sc.left_category_id == c.id,
      where: sc.right_category_id == ^category.id
    )
    |> Repo.all()
  end

  defp find_or_create_place("-", _category) do
    nil
  end

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

  defp create(%{place: nil, category: category} = params) do
    [category | similar_categories(category)]
    |> Enum.each(fn c ->
      params
      |> merge(%{category: c})
      |> create_without_place
    end)
  end

  defp create(%{user: user, place: place, category: category} = params) do
    attrs =
      %{
        state: "active",
        user_id: user.id,
        category_id: category.id,
        place_id: place.id
      }
      |> merge(params)

    base_create(attrs)
  end

  defp create_without_place(%{user: user, category: category} = params) do
    attrs =
      %{
        state: "active",
        user_id: user.id,
        category_id: category.id
      }
      |> merge(params)

    base_create(attrs)
  end

  defp base_create(params) do
    %BonusProgram{}
    |> BonusProgram.changeset(params)
    |> Repo.insert()
  end
end
