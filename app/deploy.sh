#!/bin/bash
cd /var/acme_bank
####This had to be added to execute deps.get in a good way###########
mix local.hex --force
mix local.rebar --force
####################################################################
mix deps.get
mix deps.update postgrex
mix ecto.setup
(cd apps/bank_web && npm install) && (cd apps/backoffice && npm install)
mix phoenix.server
