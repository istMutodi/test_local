# docker_postgress

# 概要
- ローカル環境に新サービス基盤のDB（postgres）を構築する。

# 構成

| ルート | １階層 | ２階層 | 説明 |
| ------ | ------ | ------ | ------ |
| README.md |  | | 本ファイル |
| docker-compose.yml |  | | yamlファイル。「docker-compose up -d」 により、<br>・postgresコンテナ<br>・DB管理コンテナ（adminer）<br>の２種類のコンテナが構築される。| 
| postgres/ | | | postgresコンテナ構築に関連する資産 |
| - | dockerfile/ | dockerfile | postgresの日本語化対応。<br>（イメージは「postgres:latest」を仕様）※バージョン指定が必要であれば変更する|
| - | data/ | | 永続ストレージ化のマウント先ディレクトリ（必要） |
| - | initdb.d/ | | postgresイメージの初期ビルド時に、１度のみ実行されるファイル群<br>（ファイル名順に処理が実行されます）<br>※実行されるファイルは(*.sql | *.sql.gz | *.sh) |
|  | - | 01.createTable.sql | 新サービスに必要な各種テーブルの構築ファイル。<br>対象のDBはyamlの「POSTGRES_DB」に記載したDBに構築される。<br><b>作成するスキーマ名の定義があるので任意の名称に変更すること。（def:'user1'）</b>|
|  | - | 02.testData.sql | 初期構築時に、あらかじめテストデータを追加しておきたい場合に使用。<br>中にはINSERT文のサンプルコードが記載されている。（不要であれば削除して構いません） <br><b>追加するスキーマ名の定義があるので任意の名称に変更すること。（def:'user1'）</b>|

# 使用時の変更箇所
- 主な変更箇所は以下の通り。

## <docker-compose.yml>
| # | 内容 | 説明 |
| ------ | ------ | ------ |
| 1 | services.db.environment.POSTGRES_DB | データベース名（def:DB_NAME） |
| 2 | services.adminer.ports | ポート番号。自身のローカルで立ち上げている他コンテナ群と調整して下さい。（バッティングしないように） |

## <01.createTable.sql>
| # | 内容 | 説明 |
| ------ | ------ | ------ |
| 1 | (#13)「\set schema_name 'user1'」 | スキーマ名。ユーザーに合わせ修正下さい。 |

## <02.testData.sql>
| # | 内容 | 説明 |
| ------ | ------ | ------ |
| 1 | (#13)「\set schema_name 'user1'」 | スキーマ名。ユーザーに合わせ修正下さい。 |

# 参考

*  <a href="https://hub.docker.com/_/postgres">【Docker Hub】 postgres</a>
*  <a href="https://qiita.com/kisk_tech/items/eb142b2287779e0751ee">【Qiita】Docker for Mac で 日本語locale設定を含む PostgreSQL を構築</a>
*  <a href="https://goodbyegangster.hatenablog.com/entry/2018/10/22/034138">【goodbyegangsterのブログ】「Aurora PostgreSQLの照合順序(言語のロケール)とタイムゾーンの設定」</a>
*  <a href="https://qiita.com/nobuyuki-ishii/items/dfd1f0e447f495bf5aac">【Qiita】PostgreSQL備忘録</a>
