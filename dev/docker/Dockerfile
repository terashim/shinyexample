FROM rocker/rstudio:4.1.0

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
        ssh \
        libxt-dev \
    && apt-get clean

# remotes と renv をインストール
RUN R -e "install.packages('remotes')"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

# renv のパッケージキャッシュおよびライブラリルート用フォルダを作成
# SSH の known_hosts に github.com を追加
RUN mkdir -p /home/rstudio/.local/share/renv/cache \
  && mkdir -p /home/rstudio/.ssh \
  && mkdir -p /home/rstudio/.renv/library \
  && ssh-keyscan -t rsa github.com > /home/rstudio/.ssh/known_hosts \
  && chown -R rstudio:rstudio /home/rstudio \
  && chmod 700 /home/rstudio/.ssh

# SSH Config をコピー
COPY --chown=rstudio:rstudio .ssh/config /home/rstudio/.ssh/config

# 起動スクリプトをコピー
COPY startup.sh /startup

# ポート
EXPOSE 8787
# 起動コマンドを変更
CMD [ "/startup" ]
