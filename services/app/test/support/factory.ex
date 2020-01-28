defmodule WhatIsBetterToPay.Factory do
  use ExMachina.Ecto, repo: WhatIsBetterToPay.Repo
  alias WhatIsBetterToPay.{Repo, User, Category, Place, BonusProgram}

  def user_factory do
    %User{
      username: sequence(:username, &"user_#{&1}"),
      first_name: sequence(:username, &"User #{&1}"),
      last_name: sequence(:username, &"User #{&1}"),
      telegram_id: :rand.uniform(9_999_999) |> Integer.to_string
    }
  end

  def category_factory do
    %Category{
      title: sequence(:title, &"category #{&1}")
    }
  end

  def place_factory do
    %Place{
      title: sequence(:title, &"category #{&1}"),
      category: build(:category)
    }
  end

  def bonus_program_factory(
    %{
      multipurpose: multipurpose,
      state: state,
      percentage: percentage
    }
  ) do
    %BonusProgram{
      card_title: sequence(:card_title, &"card #{&1}"),
      multipurpose: false,
      percentage: percentage || 0.05,
      state: state or "active"
    }
  end
end
