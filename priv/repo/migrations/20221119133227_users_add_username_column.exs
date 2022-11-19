defmodule Pento.Repo.Migrations.UsersAddUsernameColumn do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :username, :citext
    end
  end
end
