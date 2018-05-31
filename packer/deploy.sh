#!/bin/bash
set -e

branch=$1

cd /home/ubuntu/

function check_branch_exists {
    local branch_hash

    branch_hash=$(git ls-remote git@github.com:Secasp/exilir_bank.git "${branch}")

    if [[ -z "${branch_hash}" ]]; then
        echo "Branch ${BRANCH} does not exist"
        exit 1
    fi
}

check_branch_exists

if [ -d "$branch" ]; then
    cd $branch
    git fetch --all
    git reset --hard origin/$branch

else
    git clone --depth=1 -b $1 git@github.com:Secasp/exilir_bank.git exilir_bank
    cd $branch

fi

cd elixir_bank/app/
git clone https://github.com/wojtekmach/acme_bank.git acme_bank
tar -cvf acme_bank.tar acme_bank
docker build -t bank_app_elixir .
cd ../db/
docker build -t bank_db .
#Rebuild docker container if there is any change
cd ../compose/
docker-compose up --build

