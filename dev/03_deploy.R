# 堅牢でプロダクションレディな Shiny アプリケーションの開発
# 
# README: dev ファイルにある各ステップは任意です. すべての内容を記入しなくても開発を始めることは可能です.
# 00_renv.R は renv による依存関係管理で使用します.
# 01_start.R は開発の開始時に記入する内容です.
# 02_dev.R はこのプロジェクトの開発中に使用する内容です.
# 03_deploy.R はアプリをデプロイしたいときに使用します.
# 
# 
###############################################
#### 現在のファイル: デプロイ用スクリプト #####
###############################################

# テスト

## check を実行 ----
## 本番化の前にパッケージをチェック
devtools::check()
rhub::check_for_cran()

# デプロイ

## RStudio ----
## RStudio系プラットフォームにデプロイする場合
# golem::add_rstudioconnect_file()
# golem::add_shinyappsio_file()
# golem::add_shinyserver_file()

## Docker ----
## 一般的な Dockerfile でデプロイする場合
# golem::add_dockerfile()

## ShinyProxy にデプロイする場合
# golem::add_dockerfile_shinyproxy()

## Heroku にデプロイする場合
# golem::add_dockerfile_heroku()
