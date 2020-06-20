defmodule Fish.Marketing.Blog do
  use Fish.Schema
  import Ecto.Changeset

  schema "blogs" do
    field :content, :string
    field :title, :string
    belongs_to :author, Fish.Users.User

    timestamps()
  end

  @doc false
  def changeset(blog, attrs) do
    blog
    |> cast(attrs, [:title, :content])
    |> validate_required([:title, :content])
  end
end
