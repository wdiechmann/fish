defmodule Fish.UserIdentities.UserIdentity do
  use Fish.Schema
  use PowAssent.Ecto.UserIdentities.Schema, user: Fish.Users.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "user_identities" do
    pow_assent_user_identity_fields()

    timestamps()
  end
end
