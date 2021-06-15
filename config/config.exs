# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

# Sample configuration:
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]
#

case Mix.env() do
  :prod ->
    config :kv, :routing_table, [
      {?a..?m, :foo@updated2019},
      {?n..?z, :bar@updated2019}
    ]

  :test ->
    config :kv, :routing_table, [{?a..?z, node()}]

  :dev ->
    config :kv, :routing_table, [{?a..?z, node()}]
end

# config :kv, :routing_table, [{?a..?z, node()}]
