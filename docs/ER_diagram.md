erDiagram
    %% ユーザー（認証・共通アカウント）
    users {
        int id PK "ID"
        string email "メールアドレス(UK)"
        string password_hash "パスワード(ハッシュ化)"
        string provider "google or local"
        string provider_id "GoogleのID等"
        enum role "権限(GENERAL/AUFGUSSER/ADMIN)"
        string name "ニックネーム"
        datetime created_at "登録日時"
    }

    %% アウフギーサー（プロフィール情報）
    aufgussers {
        int id PK "ID"
        int user_id FK "ログインアカウントID(UK)"
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

    %% 出演スケジュール
    schedules {
        int id PK "ID"
        int aufgusser_id FK "誰が"
        int facility_id FK "どこで"
        datetime event_datetime "いつ"
        enum gender_limit "男女制限"
        int price "追加料金"
        string reservation_url "予約URL"
    }

    %% ログ（ユーザーの記録）
    logs {
        int id PK "ID"
        int user_id FK "ユーザー"
        int schedule_id FK "イベント"
        text comment "ひとこと"
    }

    %% リレーション
    users ||--o| aufgussers : "1対1(アウフギーサーの場合)"
    users ||--o{ logs : "記録"
    aufgussers ||--o{ schedules : "出演"
    facilities ||--o{ schedules : "開催"
    schedules ||--o{ logs : "記録"
