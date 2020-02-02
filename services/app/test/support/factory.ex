defmodule WhatIsBetterToPay.Factory do
  use ExMachina.Ecto, repo: WhatIsBetterToPay.Repo

  alias WhatIsBetterToPay.{
    Repo,
    User,
    Category,
    Place,
    BonusProgram,
    SimilarCategory,
    PlaceLocation
  }

  def user_factory do
    %User{
      username: sequence(:username, &"user_#{&1}"),
      first_name: sequence(:username, &"User #{&1}"),
      last_name: sequence(:username, &"User #{&1}"),
      telegram_id: :rand.uniform(9_999_999) |> Integer.to_string()
    }
  end

  def category_factory do
    %Category{
      title: sequence(:title, &"category #{&1}")
    }
  end

  def similar_category_factory do
    %SimilarCategory{
      left_category: build(:category),
      right_category: build(:category)
    }
  end

  def place_factory do
    %Place{
      title: sequence(:title, &"category #{&1}"),
      category: build(:category)
    }
  end

  def bonus_program_factory do
    %BonusProgram{
      card_title: sequence(:card_title, &"card #{&1}"),
      multipurpose: false,
      percentage: 0.05,
      state: "active",
      category: build(:category),
      place: build(:place),
      user: build(:user)
    }
  end

  def place_location_factory do
    %PlaceLocation{
      place: build(:place),
      lng_lat_point: {
        PlaceLocation.build_lng_lat_point({
          # from -180 to 180
          :rand.uniform(361) - 181,
          # from -90 to 90
          :rand.uniform(181) - 91
        })
      }
    }
  end
end
