defmodule NetguruAssignment.AuthorsTest do
  use NetguruAssignment.DataCase

  alias NetguruAssignment.Authors

  describe "authors" do
    alias NetguruAssignment.Authors.Author

    @valid_attrs %{age: 42, first_name: "some first_name", last_name: "some last_name"}
    @update_attrs %{
      age: 43,
      first_name: "some updated first_name",
      last_name: "some updated last_name"
    }
    @invalid_attrs %{age: nil, first_name: nil, last_name: nil}

    def author_fixture(attrs \\ %{}) do
      {:ok, author} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Authors.create_author()

      author
    end

    test "get_author!/1 returns the author with given id" do
      author = author_fixture()
      assert Authors.get_author!(author.id) == author
    end

    test "create_author/1 with valid data creates an author" do
      assert {:ok, %Author{} = author} = Authors.create_author(@valid_attrs)
      assert author.age == 42
      assert author.first_name == "some first_name"
      assert author.last_name == "some last_name"
    end

    test "create_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Authors.create_author(@invalid_attrs)
    end

    test "update_author/2 with valid data updates the author" do
      author = author_fixture()
      assert {:ok, %Author{} = author} = Authors.update_author(author, @update_attrs)
      assert author.age == 43
      assert author.first_name == "some updated first_name"
      assert author.last_name == "some updated last_name"
    end

    test "update_author/2 with invalid data returns error changeset" do
      author = author_fixture()
      assert {:error, %Ecto.Changeset{}} = Authors.update_author(author, @invalid_attrs)
      assert author == Authors.get_author!(author.id)
    end

    test "change_author/1 returns an author changeset" do
      author = author_fixture()
      assert %Ecto.Changeset{} = Authors.change_author(author)
    end

    test "change_author/1 returns error changeset (required fields)" do
      changeset = Authors.change_author(%Author{}, @invalid_attrs)

      assert %{
               first_name: ["can't be blank"],
               last_name: ["can't be blank"],
               age: ["can't be blank"]
             } = errors_on(changeset)
    end

    test "change_author/1 returns error changeset (description is too long)" do
      invalid_attrs = @valid_attrs |> Map.put(:age, 12)
      changeset = Authors.change_author(%Author{}, invalid_attrs)
      assert %{age: ["must be greater than or equal to 13"]} = errors_on(changeset)
    end

    test "get_auth_token/1 returns auth token" do
      author = author_fixture()
      {:ok, token, _claims} = Authors.get_auth_token(author)

      assert String.length(token) > 0
    end
  end
end
