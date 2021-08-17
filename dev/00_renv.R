# 堅牢でプロダクションレディな Shiny アプリケーションの開発
# 
# README: dev ファイルにある各ステップは任意です. すべての内容を記入しなくても開発を始めることは可能です.
# 00_renv.R は renv による依存関係管理で使用します.
# 01_start.R は開発の開始時に記入する内容です.
# 02_dev.R はこのプロジェクトの開発中に使用する内容です.
# 03_deploy.R はアプリをデプロイしたいときに使用します.
# 
# 
##################################################
#### 現在のファイル: renv による依存関係管理 #####
##################################################

# [基本方針]
# * アプリケーションの依存パッケージは DESCRIPTION ファイルの Imports に記述する
# * 実際にインストールされたパッケージのバージョンは renv の lock ファイルに記録する
# * 開発環境でのみ使用するパッケージは renv の profile 機能を利用して管理する

# renv 環境（開発モード）のロード ----

# 開発モードの renv 環境をロードするには, 次を実行する
Sys.setenv(RENV_PROFILE = "dev")
renv::load()
renv::restore()

# 依存パッケージの追加/変更と renv.lock ファイルの作成/更新 ----

# アプリケーションの依存パッケージを変更・追加したい場合は以下の手順を踏む

# 1. デフォルト（本番）モードの renv 環境をロードする
Sys.setenv(RENV_PROFILE = "default")
renv::load()
renv::restore()

# 2. 依存パッケージをリストアップする

# Docker イメージのビルドでキャッシュが効くようにするため,
# 安定した依存関係と流動的な依存関係を区別して扱う.

# 安定した依存関係
stable_deps <- c(
  "golem", "shiny", "config"
)

# 流動的な依存関係
unstable_deps <- c(
  "palmerpenguins"
)

all_deps <- c(stable_deps, unstable_deps)

# 3. 依存関係をインストールする
renv::install(packages = all_deps)

# 4. 依存関係を DESCRIPTION ファイルに追加する
for (pkg in all_deps) {
  usethis::use_package(pkg)
}

# 5. 依存性解決の結果を lock ファイルに記録する

# Docker ビルドでキャッシュが効くようにするため２つの lock ファイルを用意する:
# renv-base.lock: 安定した依存関係のみ
renv::snapshot(lockfile = "renv-base.lock", packages = stable_deps)
# renv.lock: すべての依存関係
renv::snapshot(lockfile = "renv.lock", type = "explicit")

# 開発用パッケージの変更 ----

# 開発環境でのみ使用するパッケージは
# DESCRIPTION ファイルの Config/renv/profiles/dev/dependencies フィールドに記載する.
# これによって devtools, renv などの開発用パッケージが
# RENV_PROFILE = dev の場合に限って追加インストールされる.

# DESCRIPTION ファイルの Config/renv/profiles/dev/dependencies フィールドを更新したときは,
# 以下の手順で開発モード用の lock ファイル renv/profiles/dev/renv.lock を更新する.

# 1. 開発モードの renv 環境をロードする
Sys.setenv(RENV_PROFILE = "dev")
renv::load()

# 2. DESCRIPTION ファイルの内容に従って依存関係をインストールする
renv::install()

# 3. ライブラリの状態を開発モード用の lock ファイル renv/profiles/dev/renv.lock に記録する
renv::snapshot(type = "explicit")

# [注意]
# usethis や testthat, roxygen2 などもアプリケーションを動作させるのには不要なので
# 本番モードではインストールせず開発モードでのみ使用する形にしたいが,
# golem 自身がこれらをインポートするため, 本番用のライブラリから分離することができない.
# 現在これらのパッケージは golem の Imports から Suggests に変更することが検討されている.
# 参考: https://github.com/ThinkR-open/golem/issues/597

# 準備完了！ ----

# dev/01_start.R へ移動する
rstudioapi::navigateToFile( "dev/01_start.R" )
