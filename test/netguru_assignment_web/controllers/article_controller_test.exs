defmodule NetguruAssignmentWeb.ArticleControllerTest do
  use NetguruAssignmentWeb.ConnCase

  alias NetguruAssignment.Articles
  alias NetguruAssignment.Authors

  @author_attrs %{
    age: 42,
    first_name: "some first_name",
    last_name: "some last_name"
  }
  @create_attrs %{
    body: "some body",
    description: "some description",
    published_date: ~N[2010-04-17 14:00:00],
    title: "some title"
  }
  @invalid_attrs %{body: nil, description: nil, published_date: nil, title: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "returns Unauthorized when no token", %{conn: conn} do
      conn = get(conn, Routes.article_path(conn, :index))

      assert response(conn, 401)
    end

    test "lists all articles", %{conn: conn} do
      author = create_author()
      conn = conn
        |> sign_in_author(author)
        |> get(Routes.article_path(conn, :index))

      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create article" do
    test "returns Unathorized when no token", %{conn: conn} do
      conn = post(conn, Routes.article_path(conn, :create), article: @create_attrs)

      assert response(conn, 401)
    end

    test "renders article when data is valid", %{conn: conn} do
      author = create_author()
      conn = conn
      |> sign_in_author(author)
      |> post(Routes.article_path(conn, :create), article: @create_attrs)

      assert %{"id" => id} = json_response(conn, 201)["data"]

      assert %{
               "id" => ^id,
               "body" => "some body",
               "description" => "some description",
               "title" => "some title"
             } = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      author = create_author()
      conn = conn
        |> sign_in_author(author)
        |> post(Routes.article_path(conn, :create), article: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete article" do
    test "returns Unathorized when no token", %{conn: conn} do
      author = create_author()
      article = create_article(author)
      conn = delete(conn, Routes.article_path(conn, :delete, article))

      assert response(conn, 401)
    end

    test "returns Unathorized when article does not belong to author", %{conn: conn} do
      author1 = create_author()
      author2 = create_author() 
      article = create_article(author1)

      conn = conn
        |> sign_in_author(author2) 
        |> delete(Routes.article_path(conn, :delete, article))
      
      assert response(conn, 401)
    end

    test "deletes chosen article", %{conn: conn} do
      author = create_author()
      article = create_article(author)

      conn = conn
        |> sign_in_author(author)
        |> delete(Routes.article_path(conn, :delete, article))

      assert response(conn, 204)

      assert_error_sent 404, fn ->
        delete(conn, Routes.article_path(conn, :delete, article))
      end
    end
  end

  defp create_author() do
    {:ok, author} = Authors.create_author(@author_attrs)
    author
  end

  defp create_article(author) do
    {:ok, article} = Articles.create_article(@create_attrs, author)
    article
  end

  defp sign_in_author(conn, author) do
    {:ok, token, _claims} = Authors.get_auth_token(author)
    conn |> put_req_header("authorization", "Bearer #{token}")
  end
end
