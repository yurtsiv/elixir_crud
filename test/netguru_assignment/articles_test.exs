defmodule NetguruAssignment.ArticlesTest do
  use NetguruAssignment.DataCase

  alias NetguruAssignment.Articles
  alias NetguruAssignment.Authors

  describe "articles" do
    alias NetguruAssignment.Articles.Article

    @author_attrs %{age: 42, first_name: "some first_name", last_name: "some last_name"}
    @valid_attrs %{
      body: "some body",
      description: "some description",
      title: "some title"
    }
    @invalid_attrs %{
      body: nil, description: "Description", published_date: nil, title: nil}

    def author_fixture() do
      {:ok, author} =
        %{}
        |> Enum.into(@author_attrs)
        |> Authors.create_author()

      author
    end

    def article_fixture(attrs \\ %{}) do
      author = author_fixture()

      {:ok, article} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Articles.create_article(author)
      
      article
    end

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Articles.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Articles.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates an article" do
      current_date = NaiveDateTime.utc_now()
      assert {:ok, %Article{} = article} = Articles.create_article(@valid_attrs, author_fixture())

      published_date = article.published_date
      assert published_date.year == current_date.year
      assert published_date.month == current_date.month
      assert published_date.day == current_date.day
      assert article.body == "some body"
      assert article.description == "some description"
      assert article.title == "some title"
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Articles.create_article(@invalid_attrs, author_fixture())
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Articles.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Articles.get_article!(article.id) end
    end

    test "change_article/1 returns an article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Articles.change_article(article)
    end

    test "change_article/1 returns error changeset (required fields)" do
      changeset = Articles.change_article(%Article{}, @invalid_attrs)
      assert %{body: ["can't be blank"], title: ["can't be blank"]} = errors_on(changeset)
    end

    test "change_article/1 returns error changeset (description is too long)"  do
      invalid_attrs = @valid_attrs |> Map.put(:title, String.duplicate("title", 150))
      changeset = Articles.change_article(%Article{}, invalid_attrs)
      assert %{title: ["should be at most 150 character(s)"]} = errors_on(changeset)
    end

    test "preload_author/1 loads author of a given article" do
      article = article_fixture() |> Articles.preload_author()

      assert article.author.age == @author_attrs.age
    end
  end
end
