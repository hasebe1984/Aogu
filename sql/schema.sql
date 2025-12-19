-- 既存のテーブルがあれば削除（作り直し用）
DROP TABLE IF EXISTS logs;
DROP TABLE IF EXISTS schedule_styles;
DROP TABLE IF EXISTS schedules;
DROP TABLE IF EXISTS reactions;
DROP TABLE IF EXISTS styles;
DROP TABLE IF EXISTS facilities;
DROP TABLE IF EXISTS aufgussers;
DROP TABLE IF EXISTS users;

-- 1. ユーザー（ファン）
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    line_user_id VARCHAR(255)
);

-- 2. アウフギーサー（熱波師）
CREATE TABLE aufgussers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    home_sauna VARCHAR(100),
    image_url VARCHAR(255)
);

-- 3. 施設
CREATE TABLE facilities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    prefecture VARCHAR(50),
    website_url VARCHAR(255)
);

-- 4. スタイルタグ（激熱など）
CREATE TABLE styles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    color VARCHAR(20) DEFAULT '#FFFFFF'
);

-- 5. リアクション（評価スタンプ）
CREATE TABLE reactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    label VARCHAR(50) NOT NULL,
    icon_url VARCHAR(255)
);

-- 6. 出演スケジュール
CREATE TABLE schedules (
    id INT AUTO_INCREMENT PRIMARY KEY,
    aufgusser_id INT NOT NULL,
    facility_id INT NOT NULL,
    event_datetime DATETIME NOT NULL,
    gender_limit VARCHAR(20) DEFAULT 'MIXED', -- MALE, FEMALE, MIXED
    reservation_type VARCHAR(20) DEFAULT 'NONE', -- NONE, BOOKING, TICKET
    price INT DEFAULT 0,
    reservation_url VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (aufgusser_id) REFERENCES aufgussers(id),
    FOREIGN KEY (facility_id) REFERENCES facilities(id)
);

-- 7. スケジュールとタグの中間テーブル
CREATE TABLE schedule_styles (
    schedule_id INT NOT NULL,
    style_id INT NOT NULL,
    PRIMARY KEY (schedule_id, style_id),
    FOREIGN KEY (schedule_id) REFERENCES schedules(id),
    FOREIGN KEY (style_id) REFERENCES styles(id)
);

-- 8. 参加ログ
CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    schedule_id INT NOT NULL,
    reaction_id INT NOT NULL,
    comment TEXT,
    logged_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (schedule_id) REFERENCES schedules(id),
    FOREIGN KEY (reaction_id) REFERENCES reactions(id)
);