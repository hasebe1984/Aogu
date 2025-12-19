# データベース設計 (ER図)

アプリケーション名: **Aogu (アオグ)**

```mermaid
erDiagram
    %% アウフギーサー（熱波師）
    aufgussers {
        int id PK "ID"
        string name "活動名"
        string home_sauna "所属/ホーム"
        string image_url "アー写URL"
    }

    %% 施設（サウナ）
    facilities {
        int id PK "ID"
        string name "施設名"
        string prefecture "都道府県"
        string website_url "公式HPのURL"
    }

    %% 出演スケジュール（イベント）
    schedules {
        int id PK "ID"
        int aufgusser_id FK "誰が"
        int facility_id FK "どこで"
        datetime event_datetime "いつ"
        enum gender_limit "男女制限(MALE/FEMALE/MIXED)"
        enum reservation_type "予約タイプ(NONE/BOOKING/TICKET)" 
        int price "追加料金(0なら無料)" 
        string reservation_url "予約ページURL"
        datetime created_at "登録日時"
    }

    %% スタイルタグ
    styles {
        int id PK "ID"
        string name "タグ名"
        string color "タグの色"
    }

    %% スケジュールとタグの中間テーブル
    schedule_styles {
        int schedule_id FK
        int style_id FK
    }

    %% ユーザー
    users {
        int id PK "ID"
        string name "ニックネーム"
        string line_user_id "LINE連携用ID"
    }

    %% 参加ログ（感覚ログ）
    logs {
        int id PK "ID"
        int user_id FK "ユーザー"
        int schedule_id FK "イベント"
        int reaction_id FK "スタンプ"
        text comment "ひとこと"
        datetime logged_at "記録日時"
    }
    
    %% リアクションマスタ
    reactions {
        int id PK "ID"
        string label "表示名"
        string icon_url "アイコン"
    }

    %% リレーション定義
    aufgussers ||--o{ schedules : "出演"
    facilities ||--o{ schedules : "開催"
    schedules ||--o{ schedule_styles : "タグ付"
    styles ||--o{ schedule_styles : "使用"
    schedules ||--o{ logs : "記録"
    users ||--o{ logs : "記録"
    reactions ||--o{ logs : "選択"