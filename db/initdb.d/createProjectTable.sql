-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
--
--
-- スキーマ及び各種テーブルの自動構築
--
--
-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

-----------------------------------------------------------------
-- 初期設定
-----------------------------------------------------------------
-- 作成するスキーマ名
\set schema_name 'test_schema'

-- 文字コード指定
set client_encoding = 'UTF8';

-- データベース指定
-- デフォルトはyamlで[POSTGRES_DB]に定義したデータベースになる。


-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
--
--
--  処理開始
--
--
-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

-- スキーマ作成
CREATE SCHEMA :schema_name;

-- スキーマの権限を作成者より変更する場合
-- create schema schema_name authorization [所有者名];


-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
--
--
--  各種テーブル作成
--
--
-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
-----------------------------------------------------------------
-- 案件情報テーブル
-----------------------------------------------------------------
\set project 'sample_table'
CREATE TABLE :schema_name.:project (
    id              SERIAL          NOT NULL,
    enable          int             NOT NULL default 1,
    name            varchar(255)    NOT NULL,
    schema_name     varchar(64)     NOT NULL,
    bucket_name     varchar(64)     DEFAULT NULL,
    created_time    timestamp(0)    NOT NULL default CURRENT_TIMESTAMP,
    updated_time    timestamp(0)    NOT NULL default CURRENT_TIMESTAMP,
    deleted_flg     int             NOT NULL default 0,

    CONSTRAINT tbl_project_pkey PRIMARY KEY (id), -- 主キー定義
    CONSTRAINT tbl_project_schema_name UNIQUE (schema_name)
);

-- コメント
COMMENT ON TABLE :schema_name.:project                 IS '案件情報';
COMMENT ON COLUMN :schema_name.:project.id             IS 'ID';
COMMENT ON COLUMN :schema_name.:project.enable         IS '有効/無効';
COMMENT ON COLUMN :schema_name.:project.name           IS '名称';
COMMENT ON COLUMN :schema_name.:project.schema_name    IS 'DBスキーマ名';
COMMENT ON COLUMN :schema_name.:project.bucket_name    IS 'ストレージバケット名';
COMMENT ON COLUMN :schema_name.:project.created_time   IS '作成日時';
COMMENT ON COLUMN :schema_name.:project.updated_time   IS '更新日時';
COMMENT ON COLUMN :schema_name.:project.deleted_flg    IS '論理削除FLG';
