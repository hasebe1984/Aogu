/* ===============================================
Aogu Test Data (Mock Data)
=============================================== */

USE aogu;

-- 外部キーチェックを一時的に無効化（念のため）
SET FOREIGN_KEY_CHECKS = 0;

-- 既存データのクリア（重複エラー防止）
TRUNCATE TABLE logs;

TRUNCATE TABLE schedule_styles;

TRUNCATE TABLE schedules;

TRUNCATE TABLE styles;

TRUNCATE TABLE facilities;

TRUNCATE TABLE aufgussers;

TRUNCATE TABLE users;

TRUNCATE TABLE reactions;

SET FOREIGN_KEY_CHECKS = 1;

-- ===============================================
-- 1. ユーザー (Users)
-- ※パスワードはダミーです（本来はハッシュ化が必要）
-- ===============================================
INSERT INTO
    users (
        id,
        email,
        password_hash,
        name,
        role
    )
VALUES (
        1,
        'admin@aogu.com',
        '$2a$10$dummyHashValueForTest...',
        'Aogu管理者',
        'ADMIN'
    ),
    (
        2,
        'taro@aogu.com',
        '$2a$10$dummyHashValueForTest...',
        '熱波 太郎',
        'AUFGUSSER'
    ),
    (
        3,
        'hanako@aogu.com',
        '$2a$10$dummyHashValueForTest...',
        'エレガント花子',
        'AUFGUSSER'
    ),
    (
        4,
        'jiro@gmail.com',
        '$2a$10$dummyHashValueForTest...',
        'サウナ大好き次郎',
        'GENERAL'
    ),
    (
        5,
        'sauna_girl@test.com',
        '$2a$10$dummyHashValueForTest...',
        'ととのい女子',
        'GENERAL'
    );

-- ===============================================
-- 2. アウフギーサー (Aufgussers)
-- ===============================================
INSERT INTO
    aufgussers (
        id,
        user_id,
        name,
        home_sauna,
        image_url,
        introduction
    )
VALUES (
        1,
        2,
        '熱波 太郎',
        'サウナ＆カプセル 北欧',
        'https://placehold.jp/150x150.png',
        '力強いランバージャックが得意です。120度のサウナで鍛え上げました。皆さんに魂の風を送ります！'
    ),
    (
        2,
        3,
        'エレガント花子',
        'スカイスパYOKOHAMA',
        'https://placehold.jp/150x150.png',
        'クラシック音楽に合わせた優雅なタオル捌きで、心も体もリラックスさせます。アロマの香りを大切にしています。'
    );

-- ===============================================
-- 3. 施設 (Facilities)
-- ===============================================
INSERT INTO
    facilities (
        id,
        name,
        prefecture,
        address,
        website_url
    )
VALUES (
        1,
        'サウナ＆カプセル 北欧',
        '東京都',
        '東京都台東区上野7-2-16',
        'https://www.saunahokuou.com/'
    ),
    (
        2,
        'スカイスパYOKOHAMA',
        '神奈川県',
        '横浜市西区高島2-19-12 スカイビル14F',
        'https://www.skyspa.co.jp/'
    ),
    (
        3,
        '湯乃泉 草加健康センター',
        '埼玉県',
        '埼玉県草加市北谷2-23-23',
        'http://www.yunoizumi.com/souka/'
    ),
    (
        4,
        'ウェルビー栄',
        '愛知県',
        '名古屋市中区栄3-13-12',
        'https://www.wellbe.co.jp/sakae/'
    );

-- ===============================================
-- 4. スタイルタグ (Styles)
-- ===============================================
INSERT INTO
    styles (id, name, color)
VALUES (1, '激熱', '#FF0000'), -- 赤
    (2, 'リラックス', '#00BFFF'), -- 水色
    (3, 'テクニカル', '#FFA500'), -- オレンジ
    (4, 'ヒーリング', '#32CD32'), -- 緑
    (5, 'EDM系', '#8A2BE2');
-- 紫

-- ===============================================
-- 5. リアクションスタンプ (Reactions)
-- ===============================================
INSERT INTO
    reactions (id, label, icon_url)
VALUES (1, 'ととのった！', 'totono.png'),
    (2, 'あまみ出た', 'amami.png'),
    (3, '最高', 'saiko.png'),
    (4, '感動', 'kando.png'),
    (5, 'ぶっ飛んだ', 'fly.png');

-- ===============================================
-- 6. スケジュール (Schedules)
-- ===============================================
INSERT INTO
    schedules (
        id,
        aufgusser_id,
        facility_id,
        event_datetime,
        gender_limit,
        reservation_type,
        price,
        reservation_url
    )
VALUES
    -- イベント1: 熱波太郎 @ 北欧 (男性限定/予約あり)
    (
        1,
        1,
        1,
        '2025-12-24 19:00:00',
        'MALE',
        'BOOKING',
        500,
        'https://reserve.example.com/event1'
    ),
    -- イベント2: エレガント花子 @ スカイスパ (男女混合/抽選)
    (
        2,
        2,
        2,
        '2025-12-25 20:00:00',
        'MIXED',
        'LOTTERY',
        300,
        'https://reserve.example.com/event2'
    ),
    -- イベント3: 熱波太郎 @ 草加 (過去のイベント/ログ用)
    (
        3,
        1,
        3,
        '2025-12-01 18:00:00',
        'MALE',
        'NONE',
        0,
        NULL
    );

-- ===============================================
-- 7. スケジュールとタグの紐付け (Schedule Styles)
-- ===============================================
INSERT INTO
    schedule_styles (schedule_id, style_id)
VALUES (1, 1), -- イベント1は「激熱」
    (1, 3), -- イベント1は「テクニカル」
    (2, 2), -- イベント2は「リラックス」
    (2, 4), -- イベント2は「ヒーリング」
    (3, 1), -- イベント3は「激熱」
    (3, 5);
-- イベント3は「EDM系」

-- ===============================================
-- 8. 参加ログ (Logs)
-- ===============================================
INSERT INTO
    logs (
        id,
        user_id,
        schedule_id,
        reaction_id,
        comment
    )
VALUES
    -- 次郎さんがイベント3に参加したログ
    (
        1,
        4,
        3,
        1,
        '久しぶりの草加！太郎さんの熱波は相変わらず強烈で最高でした。ブロワーなしでもこの風圧はすごい。'
    ),
    -- ととのい女子さんがイベント3に参加したログ（レディースデイ設定など架空）
    (
        2,
        5,
        3,
        4,
        '初めて太郎さんの風を受けました。感動して涙が出そうになりました。また受けたい！'
    );