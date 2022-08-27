FROM elixir:1.14

RUN apt-get update && \
    apt-get install -y inotify-tools postgresql-client nodejs npm

WORKDIR /app
COPY . /app

ARG MIX_ENV="dev"
ARG SECRET_KEY_BASE=""

ENV MIX_ENV="${MIX_ENV}"
ENV SECRET_KEY_BASE="${SECRET_KEY_BASE}"

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get && \
    mix assets.deploy && \
    mix compile

RUN chmod u+x /app/script-entry-point.sh

EXPOSE 4000

CMD [ "/app/script-entry-point.sh" ]