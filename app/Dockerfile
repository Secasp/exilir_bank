#Elixir base image
FROM elixir

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils && apt-get install locales


#Provisioning Erlang-Elixir-Mix-Phoenix-Node
WORKDIR /var/
RUN apt-get update \
	&& mix local.hex \
	&& curl -sL https://deb.nodesource.com/setup_7.x | bash - \
	&& apt-get update \
	&& apt-get -y upgrade nodejs \
	&& apt-get -y install build-essential libssl-dev
	
	
#Provisioning Elixir-App
WORKDIR /var/
COPY acme_bank.tar .
RUN tar -xvf acme_bank.tar
#WORKDIR /var/acme_bank/
#COPY .env .
WORKDIR /var/
COPY deploy.sh .
RUN chmod +x deploy.sh
CMD ["/bin/bash","deploy.sh"]

