-- 文字化け防止
SET NAMES utf8mb4;

-- 1. ユーザー（ファン）
INSERT INTO users (name, line_user_id) VALUES 
('サウナ太郎', 'U123456...'),
('熱波花子', NULL),
('トトノイ次郎', NULL);

-- 2. アウフギーサー
INSERT INTO aufgussers (name, home_sauna, image_url) VALUES 
('鮭山未菜美', 'スカイスパYOKOHAMA', 'https://example.com/shake.jpg'),
('五塔熱子', 'フリー', 'https://example.com/neppa.jpg'),
('スター諸星', 'しきじ', 'https://example.com/star.jpg');

-- 3. 施設
INSERT INTO facilities (name, prefecture, website_url) VALUES 
('ウェルビー栄', '愛知', 'https://www.wellbe.co.jp/sakae/'),
('サウナ東京', '東京', 'https://sauna-tokyo.jp/'),
('湯らっくす', '熊本', 'https://www.yulax.info/');

-- 4. スタイルタグ
INSERT INTO styles (name, color) VALUES 
('激熱', '#FF0000'),       -- ID:1
('メディテーション', '#00FF00'), -- ID:2
('ショー/演舞', '#FFFF00'),    -- ID:3
('リラックス', '#0000FF');     -- ID:4

-- 5. リアクション（スタンプ）
INSERT INTO reactions (label, icon_url) VALUES 
('ととのった', 'icon_totono.png'),
('あまみ出た', 'icon_amami.png'),
('最高', 'icon_best.png'),
('ぶっ飛んだ', 'icon_fly.png');

-- 6. 出演スケジュール
-- (誰が, どこで, いつ, 男女, 予約, 料金)
INSERT INTO schedules (aufgusser_id, facility_id, event_datetime, gender_limit, reservation_type, price) VALUES 
(1, 2, '2025-12-24 14:00:00', 'MIXED', 'BOOKING', 500),  -- 鮭山さん @ サウナ東京
(1, 2, '2025-12-24 16:00:00', 'MIXED', 'BOOKING', 500),
(2, 1, '2025-12-25 19:00:00', 'MALE', 'NONE', 0),        -- 五塔さん @ ウェルビー栄
(3, 3, '2025-12-31 23:00:00', 'MIXED', 'LOTTERY', 1000); -- スター @ 湯らっくす

-- 7. スケジュールにタグ付け
-- ID:1のスケジュール(鮭山さん)は「激熱」と「ショー」
INSERT INTO schedule_styles (schedule_id, style_id) VALUES 
(1, 1), (1, 3),
(2, 1), (2, 3),
(3, 2), -- 五塔さんはメディテーション
(4, 3); -- スターはショー

-- 8. 参加ログ
INSERT INTO logs (user_id, schedule_id, reaction_id, comment) VALUES 
(1, 1, 1, '鮭山さんのタオル捌き最高でした！'),
(2, 1, 2, 'あまみが止まらない...');