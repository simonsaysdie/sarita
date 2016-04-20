ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Sarita.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Sarita.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Sarita.Repo)

