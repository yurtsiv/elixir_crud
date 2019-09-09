defmodule NetguruAssignment.Auth.Guardian do
  @moduledoc """
  Cofigures Guardian
  """

  use Guardian, otp_app: :netguru_assignment

  alias NetguruAssignment.Authors
  alias NetguruAssignment.Authors.Author

  def subject_for_token(author, _claims) do
    sub = to_string(author.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]

    case Authors.get_author(id) do
      %Author{} = author -> {:ok, author}
      nil -> {:error}
    end
  end
end
