ARG GIT_TAG=${GIT_TAG:-main}

FROM node:lts-bullseye

ARG GIT_TAG

ENV HOME=/app

WORKDIR /app

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends git && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    npm install -g pnpm && \
    git clone -b ${GIT_TAG} --depth 1 https://github.com/zyachel/quetre.git && \
    mv quetre/* . && \
    rm -r quetre && \
    cp .env.example .env && \
    pnpm install --prod && \
    chown -R 1000:1000 /app

USER 1000

EXPOSE 3000

CMD ["pnpm", "start"]
