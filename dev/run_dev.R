# オプション設定
options(golem.app.prod = FALSE) # TRUE = 本番モード, FALSE = 開発モード

# ロードされているパッケージをすべてデタッチして、クリーンな環境にする
golem::detach_all_attached()
# rm(list=ls(all.names = TRUE))

# ドキュメントを生成してパッケージをリロードする
golem::document_and_reload()

# アプリケーションを起動する
run_app()
