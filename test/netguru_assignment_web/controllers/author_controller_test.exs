defmodule NetguruAssignmentWeb.AuthorControllerTest do
  use NetguruAssignmentWeb.ConnCase

  alias NetguruAssignment.Authors
  alias NetguruAssignment.Authors.Author

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
               "id" => author_id,
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
    test "renders author when data is valid", %{conn: conn, author: %Author{id: id} = author} do
      conn = put(conn, Routes.author_path(conn, :update, author), author: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.author_path(conn, :show, id))

      assert %{
               "id" => id,
               "age" => 43,
               "first_name" => "some updated first_name",
               "last_name" => "some updated last_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, author: author} do
      conn = put(conn, Routes.author_path(conn, :update, author), author: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_author(conn) do
    conn
  end
end
