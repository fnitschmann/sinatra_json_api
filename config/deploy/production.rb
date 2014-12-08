set :stage, :production

server "srv1.nitschmann.io", user: "deploy", roles: %{web app}
