import Config

config :friends, Friends.Repo,
  database: "friends_repo",
  username: "postgres",
  password: "abcde12345",
  hostname: "localhost"

config :friends, ecto_repos: [Friends.Repo]
