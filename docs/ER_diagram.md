# データベース設計 (ER図)

## プロジェクト: Aogu (アオグ)
**最終更新日:** 2025/12/20
**概要:** サウナ・アウフグースイベントのスケジュール共有およびログ管理アプリケーション

```mermaid
erDiagram
    %% ==========================================
    %% ユーザー基盤 (User Management)
    %% ==========================================
    users {
        int id PK "ID"
        string email UK "メールアドレス(ログインID)"
        string password_hash "パスワード(ハッシュ)"
        string name "ニックネーム"
        enum role "GENERAL / AUFGUSSER / ADMIN"
        datetime created_at
        datetime updated_at
    }

    %% ==========================================
    %% アウフギーサー (Profile)
    %% ==========================================
    aufgussers {
        int id PK "ID"
        int user_id FK,UK "ユーザーID (1対1)"
        string name "活動名"
        string home_sauna "所属/ホーム"
        string image_url "アー写URL"
        text introduction "自己紹介"
    }

    %% ==========================================
    %% 施設 (Facility)
    %% ==========================================
    facilities {
        int id PK "ID"
        string name "施設名"
        string prefecture "都道府県"
        string address "住所"
        string website_url "公式HP"
    }

    %% ==========================================
    %% スケジュール (Event Core)
    %% ==========================================
    schedules {
        int id PK "ID"
        int aufgusser_id FK "誰が"
        int facility_id FK "どこで"
        datetime event_datetime "開催日時"
        enum gender_limit "MALE / FEMALE / MIXED"
        enum reservation_type "NONE / BOOKING / LOTTERY"
        int price "追加料金"
        string reservation_url "予約URL"
        datetime created_at
        datetime updated_at
    }

    %% ==========================================
    %% タグマスタ (Styles)
    %% ==========================================
    styles {
        int id PK "ID"
        string name UK "タグ名(激熱/リラックス等)"
        string color "タグ色"
    }

    %% 中間テーブル
    schedule_styles {
        int schedule_id PK,FK
        int style_id PK,FK
    }

    %% ==========================================
    %% ログ・リアクション (User Actions)
    %% ==========================================
    logs {
        int id PK "ID"
        int user_id FK "投稿者"
        int schedule_id FK "イベント"
        int reaction_id FK "リアクション"
        text comment "感想"
        datetime created_at
        datetime updated_at
    }

    reactions {
        int id PK "ID"
        string label UK "表示名(ととのった等)"
        string icon_url "アイコンURL"
    }

    %% ==========================================
    %% リレーション定義 (Relationships)
    %% ==========================================

    %% ユーザーとアウフギーサーは 1対0または1 (アウフギーサーは必ずユーザーだが、ユーザーはアウフギーサーとは限らない)
    users ||--o| aufgussers : "所有"

    %% アウフギーサーがスケジュールを作成 (1対多)
    aufgussers ||--o{ schedules : "出演"

    %% 施設でスケジュールが開催される (1対多)
    facilities ||--o{ schedules : "開催"

    %% スケジュールとスタイルは多対多 (中間テーブル経由)
    schedules ||--o{ schedule_styles : "設定"
    styles ||--o{ schedule_styles : "付与"

    %% ユーザーがログを書く (1対多)
    users ||--o{ logs : "投稿"

    %% スケジュールに対してログが書かれる (1対多)
    schedules ||--o{ logs : "記録"

    %% ログにはリアクションが付く (1対多)
    reactions ||--o{ logs : "選択"
