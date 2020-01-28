defmodule WhatIsBetterToPay.Operations.ProcessSuggestion do
  alias WhatIsBetterToPay.{User, Place, Category}
  def execute(%User{}, %Category{}) do
    # TODO:
    # 1. try to find bonus program with category or similar categories
    # 2. if nothing found try to found mulripurpose program
    # 3. compare found bonus programs, find best
    # 4. call SuggestionDecorator.decorate(bonus_program)
  end

  def execute(%User{}, %Place{}) do
    # TODO:
    # 1. try to find bonus program with place, category or similar categories
    # 2. unless something found on step call 3rd party api with synonyms
    # 3. try to find bonus program with category or similar categories
    # 4. if nothing found try to found mulripurpose program
    # 5. compare found bonus programs, find best
    # 6. call SuggestionDecorator.decorate(bonus_program)
  end
end
