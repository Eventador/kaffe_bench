# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :kaffe,
  producer: [
    endpoints: [
        "HOST0.pub.va.eventador.io": 9092,
        "HOST1.pub.va.eventador.io": 9092,
        "HOST2.pub.va.eventador.io": 9092
    ], # [hostname: port]
    topics: [],

    # optional
    partition_strategy: :random
  ]

config :logger, :console,
  level: :info
