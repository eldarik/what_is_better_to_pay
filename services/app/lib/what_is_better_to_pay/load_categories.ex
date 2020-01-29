defmodule WhatIsBetterToPay.LoadCategories do
  @moduledoc false
  @static_data_path "lib/static_data/categories.yml"
  # TODO: add mix task to sync categories, add in deploy process
  alias WhatIsBetterToPay.{Repo, Category, SimilarCategory}

  def execute do
    {:ok, categories_data} = categories_data()
    categories_data
    |> Enum.each(
      fn ({_category, data}) ->
        data |> process_category
      end
    )
  end

  defp categories_data do
    File.cwd!()
    |> Path.join(@static_data_path)
    |> YamlElixir.read_from_file
  end

  def find_or_create(title) do
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

  defp create_similar(left_category, right_category) do
    params = %{left_category_id: left_category.id, right_category_id: right_category.id}
    similar_pair = SimilarCategory |> Repo.get_by(params)
    case similar_pair do
      nil ->
        {:ok, similar_pair} =
          %SimilarCategory{}
          |> SimilarCategory.changeset(params)
          |> Repo.insert()
        similar_pair
      _ ->
        similar_pair
    end
  end

  defp process_category(%{"title" => title, "similar" => similar}) do
    category = find_or_create(title)
    similar
    |> Enum.each(
      fn(%{"title" => similar_title} = data) ->
        similar_category = find_or_create(similar_title)
        create_similar(category, similar_category)
        create_similar(similar_category, category)
      end
    )
  end

  defp process_category(%{"title" => title}) do
    find_or_create(title)
  end
end
