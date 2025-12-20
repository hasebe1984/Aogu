# データベース設計 (ER図)



アプリケーション名: **Aogu (アオグ)**



```mermaid

erDiagram
    %% ==========================================
    %% 認証・ユーザー基盤 (Authentication)
    %% ==========================================
    users {
        int id PK "ID"
        string email UK "メールアドレス (ログインID)"
        string password_hash "ハッシュ化パスワード (Google時はNULL可)"
        string name "ニックネーム"
        enum role "権限 (GENERAL / AUFGUSSER / ADMIN)"
        datetime created_at "登録日時"
        datetime updated_at "更新日時"
    }

    %% ==========================================
    %% アウフギーサー詳細 (Profile)
    %% ==========================================
    aufgussers {
        int id PK "ID"
        int user_id FK "ログインアカウントID (UK)"
        string name "活動名 (芸名)"
        string home_sauna "所属/ホームサウナ"
        string image_url "アー写URL"
        text introduction "自己紹介"
    }

    %% ==========================================
    %% 施設・マスタ (Facility)
    %% ==========================================
    facilities {
        int id PK "ID"
        string name "施設名"
        string prefecture "都道府県"
        string address "住所"
        string website_url "公式HP"
    }

    %% ==========================================
    %% イベント・スケジュール (Core Logic)
    %% ==========================================
    schedules {
        int id PK "ID"
        int aufgusser_id FK "誰が"
        int facility_id FK "どこで"
        datetime event_datetime "いつ"
        enum gender_limit "男女制限 (MALE/FEMALE/MIXED)"
        enum reservation_type "予約 (NONE/BOOKING/LOTTERY)"
        int price "追加料金"
        string reservation_url "予約ページURL"
        datetime created_at "登録日時"
    }

    %% ==========================================
    %% タグ・スタイル (Tags)
    %% ==========================================
    styles {
        int id PK "ID"
        string name "タグ名 (激熱/リラックス等)"
        string color "タグ色 (#FF0000等)"
    }

    schedule_styles {
        int schedule_id FK
        int style_id FK
    }

    %% ==========================================
    %% ログ・リアクション (User Action)
    %% ==========================================
    logs {
        int id PK "ID"
        int user_id FK "書いた人 (一般/演者問わず)"
        int schedule_id FK "参加したイベント"
        int reaction_id FK "スタンプID"
        text comment "感想コメント"
        datetime logged_at "記録日時"
    }

    reactions {
        int id PK "ID"
        string label "表示名 (ととのった！等)"
        string icon_url "アイコン画像URL"
    }

    %% ==========================================
    %% リレーション定義 (Relationships)
    %% ==========================================
    
    %% 1人のユーザーは、0または1つのアウフギーサー情報を持つ
    users ||--o| aufgussers : "所有 (Role=AUFGUSSERのみ)"

    %% アウフギーサーがスケジュールを作る
    aufgussers ||--o{ schedules : "出演"

    %% 施設でスケジュールが行われる
    facilities ||--o{ schedules : "開催"

    %% スケジュールにタグが付く (多対多)
    schedules ||--o{ schedule_styles : "設定"
    styles ||--o{ schedule_styles : "付与"

    %% ユーザーがログを書く
    users ||--o{ logs : "記録"
    
    %% スケジュールに対してログが付く
    schedules ||--o{ logs : "被評価"
    
    %% ログにはリアクションが付く
    reactions ||--o{ logs : "選択"
