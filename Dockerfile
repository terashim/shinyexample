FROM rocker/r-ver:4.1.0

ENV RENV_VERSION 0.14.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git-core \
        libcurl4-openssl-dev \
        libgit2-dev \
        libicu-dev \
        libssl-dev \
        libxml2-dev \
        make \
        pandoc \
        pandoc-citeproc \
        fonts-ipaexfont \
    && apt-get clean

# remotes と renv をインストール
RUN R -e "install.packages('remotes')"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

RUN mkdir /build_zone
WORKDIR /build_zone

# ビルドキャッシュが効くよう安定した依存パッケージは下のレイヤでインストールしておく
ADD renv-base.lock /build_zone/renv-base.lock
RUN R -e 'renv::restore(lockfile="renv-base.lock")'

# 依存パッケージをインストールする
ADD renv.lock /build_zone/renv.lock
RUN R -e 'renv::restore(lockfile="renv.lock")'
# ローカルで開発した Shiny アプリパッケージをインストールする
ADD . /build_zone
RUN R -e 'remotes::install_local(upgrade="never")'

# 開放するポート
EXPOSE 80
# 起動コマンド
CMD R -e "options('shiny.port'=80,shiny.host='0.0.0.0');shinyexample::run_app()"
