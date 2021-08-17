# 堅牢でプロダクションレディな Shiny アプリケーションの開発
# 
# README: dev ファイルにある各ステップは任意です. すべての内容を記入しなくても開発を始めることは可能です.
# 00_renv.R は renv による依存関係管理で使用します.
# 01_start.R は開発の開始時に記入する内容です.
# 02_dev.R はこのプロジェクトの開発中に使用する内容です.
# 03_deploy.R はアプリをデプロイしたいときに使用します.
# 
# 
#############################################
#### 現在のファイル: 開発中のスクリプト #####
#############################################

# エンジニアリング

## モジュールを追加 ----
## R/ ディレクトリにモジュール定義用のファイルを追加
golem::add_module( name = "name_of_module1" ) # モジュールの名前
golem::add_module( name = "name_of_module2" ) # モジュールの名前

## ヘルパー関数を追加 ----
## ftc_* や utils_* を作成
golem::add_fct( "helpers" ) 
golem::add_utils( "helpers" )

## 外部リソース
## inst/app/www ディレクトリに .js ファイルや .css ファイルを作成
golem::add_js_file( "script" )
golem::add_js_handler( "handlers" )
golem::add_css_file( "custom" )

## 内部データセットを追加 ----
## パッケージ内にデータを持たせたいとき
usethis::use_data_raw( name = "my_dataset", open = FALSE ) 

## テスト----
## テストを作成したいときは１行追加する
usethis::use_test( "app" )

# ドキュメンテーション

## Vignette（ヴィニエット）----
usethis::use_vignette("shinyexample")
devtools::build_vignettes()

## コードカバレッジ ----
## (これには GitHub が必要)
usethis::use_github()
usethis::use_travis()
usethis::use_appveyor()

# 準備完了！ ----
# dev/03_deploy.R へ移動する
rstudioapi::navigateToFile("dev/03_deploy.R")

