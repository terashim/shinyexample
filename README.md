shinyexample
==================================================

Shiny アプリケーション開発プロジェクトのサンプル.
golem のプロジェクトテンプレート
[shinyexample](https://github.com/ThinkR-open/golem/tree/master/inst/shinyexample)
を元に作成.

## 特徴

- [golem](https://thinkr-open.github.io/golem/) による Shiny アプリ開発
- [renv](https://rstudio.github.io/renv/) によるパッケージ管理
- [Docker](https://www.docker.com/) / [rocker](https://www.rocker-project.org/) による開発環境およびアプリケーションのコンテナ化

## 構成

* 開発環境用 RStudio Server コンテナ
    * [`dev/docker/Dockerfile`](./dev/docker/Dockerfile) でビルドされる Docker イメージ
    * [`rocker/rstudio`](https://hub.docker.com/r/rocker/rstudio) をベースとする
    * パッケージはイメージ内に含まれず, renv のパッケージキャッシュを使って Docker ホストからボリュームとしてマウントする
    * Shiny アプリケーションの開発時にブラウザで [localhost:8787](http://localhost:8787) からアクセスして使用する
* Shiny アプリケーションコンテナ
    * [`./Dockerfile`](./Dockerfile) でビルドされる Docker イメージ
    * [`rocker/r-ver`](https://hub.docker.com/r/rocker/r-ver) をベースとする
    * 開発したパッケージ (Shiny アプリ) と依存関係パッケージがインストールされた状態でイメージに含まれる
    * RStudio を含まない
    * 開発した Shiny アプリのサービスがポート 80 で起動する

## 初期設定

次のようにして開発環境の初期設定を行う.

- このプロジェクトの GitHub リポジトリをローカル環境の適当な場所（例: `~/ghq/github.com/username/shinyexample`）にクローンする.
- [`.env.example`](./.env.example) ファイルをコピーして `.env` ファイルを作成する.
- `.env` ファイルを編集して下記の項目を設定する.

| 環境変数                 | 意味                                            | デフォルト         | 変更例                                      |
|:-------------------------|:------------------------------------------------|:-------------------|:--------------------------------------------|
| `RENV_PATHS_CACHE_HOST`  | renv パッケージキャッシュのディレクトリパス     | `./dev/renv/cache` | `~/Library/Application Support/renv/cache`  |
| `DOTFILES_ROOT`          | dotfiles のディレクトリパス （任意）            | `./dev/dotfiles`   | `~/ghq/username/rproject-dotfiles`          |
| `GITHUB_SSH_IDENTITY`    | GitHub 接続用 SSH 秘密鍵のファイルパス （任意） | `/dev/null`        | `~/.ssh/id_rsa`                             |

renv のパッケージキャッシュはホストマシンに１つ作成して固定し, プロジェクト間で共有するのが推奨.
Dotfiles や GitHub 用 SSH 鍵は設定しなくても開発可能.

## 開発フロー

### 開発環境の起動〜終了

1. このディレクトリで `docker compose up -d` を実行して RStudio Server の Docker コンテナを起動する
2. ブラウザで <http://localhost:8787> を開き RStudio Server に接続する
3. RStudio Server 上で開発を行う
    - RStudio でこのプロジェクトを開く
    - [`dev/00_renv.R`](./dev/00_renv.R) の内容に従って renv 環境をロードする
    - 初回は [`dev/01_start.R`](./dev/01_start.R) の内容に沿って初期設定を行う
    - [`dev/02_dev.R`](dev/02_dev.R) にあるヘルパー関数を利用しながらソースコードの編集, テストなどを行う
4. 開発を中断するときは, このディレクトリで `docker compose down` を実行して Docker コンテナを停止する

### アプリケーションイメージのビルドと動作確認

1. このディレクトリで `docker compose build` を実行して, Shiny アプリケーションのイメージをビルドする
2. `docker compose restart shiny` でビルドしたイメージからコンテナを起動する
3. ブラウザで <http://localhost:8080> を開き, Shiny Server に接続する
4. Shiny アプリケーションの動作を確認する

## 参考リンク

* [Engineering Production-Grade Shiny Apps](https://engineering-shiny.org/)
* [Using renv with Docker • renv](https://rstudio.github.io/renv/articles/docker.html)
* [terashim/rproject: Git/GitHub、Docker、RStudio、renv を利用した R プロジェクトのひな形](https://github.com/terashim/rproject)
* [renv と Docker の相互運用パターン - terashim.com](https://terashim.com/posts/renv-docker-patterns/)
* [RStudio のオプション設定を dotfiles で管理する - terashim.com](https://terashim.com/posts/rstudio-dotfiles/)
