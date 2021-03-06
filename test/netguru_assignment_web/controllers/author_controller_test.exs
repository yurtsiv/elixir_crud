defmodule NetguruAssignmentWeb.AuthorControllerTest do
  use NetguruAssignmentWeb.ConnCase

  alias NetguruAssignment.Authors

  @create_attrs %{
    age: 42,
    first_name: "some first_name",
    last_name: "some last_name"
  }
  @update_attrs %{
    age: 43,
    first_name: "some updated first_name",
    last_name: "some updated last_name"
  }
  @invalid_attrs %{age: nil, first_name: nil, last_name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create author" do
    test "renders author and token when data is valid", %{conn: conn} do
      conn = post(conn, Routes.author_path(conn, :create), author: @create_attrs)

      resp_data = json_response(conn, 200)["data"]
      author_id = resp_data["author"]["id"]

      assert %{
               "id" => ^author_id,
               "age" => 42,
               "first_name" => "some first_name",
               "last_name" => "some last_name"
             } = resp_data["author"]

      assert String.length(resp_data["token"]) > 0
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.author_path(conn, :create), author: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update author" do
    test "returns Unauthorized status when no token", %{conn: conn} do
      {author, _token} = create_author()

      conn = put(conn, Routes.author_path(conn, :update, author), author: @update_attrs)
      assert conn.status == 401
    end

    test "returns Unathorized status when author tries to update details of another author", %{conn: conn} do
      {_author1, token1} = create_author()
      {author2, _token2} = create_author()

      conn =
        conn
        |> sign_in_author(token1)
        |> put(Routes.author_path(conn, :update, author2), author: @update_attrs)

      assert response(conn, 401)
    end

    test "renders author when data is valid", %{conn: conn} do
      {author, token} = create_author()

      conn =
        conn
        |> sign_in_author(token)
        |> put(Routes.author_path(conn, :update, author), author: @update_attrs)

      assert %{"id" => id} = json_response(conn, 200)["data"]

      assert %{
               "id" => id,
               "age" => 43,
               "first_name" => "some updated first_name",
               "last_name" => "some updated last_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      {author, token} = create_author()

      conn =
        conn
        |> sign_in_author(token)
        |> put(Routes.author_path(conn, :update, author), author: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "show author" do
    test "returns Unauthorized when no token", %{conn: conn} do
      {author, _token} = create_author()

      conn = get(conn, Routes.author_path(conn, :show, author), %{"id" => author.id})
      assert conn.status == 401
    end

    test "renders author", %{conn: conn} do
      {author, token} = create_author()

      conn =
        conn
        |> sign_in_author(token)
        |> get(Routes.author_path(conn, :show, author), %{"id" => author.id})

      assert author = json_response(conn, 200)["data"]
    end
  end

  defp create_author() do
    {:ok, author} = Authors.create_author(@create_attrs)
    {:ok, token, _claims} = Authors.get_auth_token(author)
    {author, token}
  end

  defp sign_in_author(conn, token) do
    conn |> put_req_header("authorization", "Bearer #{token}")
  end
end
