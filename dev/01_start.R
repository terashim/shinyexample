# 堅牢でプロダクションレディな Shiny アプリケーションの開発
# 
# README: dev ファイルにある各ステップは任意です. すべての内容を記入しなくても開発を始めることは可能です.
# 00_renv.R は renv による依存関係管理で使用します.
# 01_start.R は開発の開始時に記入する内容です.
# 02_dev.R はこのプロジェクトの開発中に使用する内容です.
# 03_deploy.R はアプリをデプロイしたいときに使用します.
# 
# 
#################################################
#### 現在のファイル: 開発開始時のスクリプト #####
#################################################

## DESCRIPTION の内容を記入 ----
## アプリケーションのメタデータを追加する
golem::fill_desc(
  pkg_name = "shinyexample", # このアプリ開発パッケージの名前
  pkg_title = "PKG_TITLE", # このアプリ開発パッケージのタイトル
  pkg_description = "PKG_DESC.", # このアプリ開発パッケージの説明文
  author_first_name = "AUTHOR_FIRST", # あなたの下の名前
  author_last_name = "AUTHOR_LAST", # あなたの苗字
  author_email = "AUTHOR@MAIL.COM", # あなたのメールアドレス
  repo_url = NULL # GitHub リポジトリの URL (任意)
)

## {golem} のオプション設定 ----
golem::set_golem_options()

## 一般的なファイルを作成 ----
## 詳しくは ?usethis を参照のこと
usethis::use_mit_license( copyright_holder = "Golem User" )  # 別のライセンスも使用可能
usethis::use_readme_rmd( open = FALSE )
usethis::use_code_of_conduct()
usethis::use_lifecycle_badge( "Experimental" )
usethis::use_news_md( open = FALSE )

## git を使用する ----
usethis::use_git()

## テストフレームワークの準備 ----
## テストのテンプレートを作成
golem::use_recommended_tests()

## 推奨パッケージを使用 ----
golem::use_recommended_deps()

## Favicon ----
# ファビコンを変えたい場合 (デフォルトでは golem のファビコンになっている)
golem::remove_favicon()
golem::use_favicon() # path = "path/to/ico". ネット上のファイルでもOK.

## ヘルパー関数を追加 ----
golem::use_utils_ui()
golem::use_utils_server()

# 準備完了！ ----

# dev/02_dev.R へ移動する
rstudioapi::navigateToFile( "dev/02_dev.R" )
