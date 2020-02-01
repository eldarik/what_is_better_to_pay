defmodule WhatIsBetterToPay.Services.GoogleDocsTest do
  use ExUnit.Case

  import Mock
  alias WhatIsBetterToPay.Services.GoogleDocs

  describe "fetch_document" do
    @link "https://docs.google.com/spreadsheets/d/foobar/editblahblah"

    test "returns document body" do
      body = "header1,header2"
      get_mock = fn _url -> {:ok, %HTTPoison.Response{body: body}} end

      with_mock HTTPoison, get: get_mock do
        result = GoogleDocs.fetch_document(@link)
        assert result == body
      end
    end

    test "returns nil when response is not successful" do
      get_mock = fn _url -> {:ok, nil} end

      with_mock HTTPoison, get: get_mock do
        result = GoogleDocs.fetch_document(@link)
        assert result == nil
      end
    end

    test "returns nil if link does not match google doc link" do
      get_mock = fn _url -> {:ok, nil} end

      with_mock HTTPoison, get: get_mock do
        result = GoogleDocs.fetch_document("foobar")
        assert result == nil
      end
    end
  end

  describe "valid_link?" do
    @link "https://docs.google.com/spreadsheets/d/foobar/editblahblah"

    test "returns true when link is valid" do
      assert GoogleDocs.valid_link?(@link) == true
    end

    test "returns false when link is valid" do
      assert GoogleDocs.valid_link?("foobar") == false
    end
  end
end
