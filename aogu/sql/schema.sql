-- ===============================================
-- データベース作成
-- ===============================================
CREATE DATABASE IF NOT EXISTS aogu DEFAULT CHARACTER SET utf8mb4;

USE aogu;

-- ===============================================
-- 既存テーブルの削除
-- ===============================================
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS logs;

DROP TABLE IF EXISTS schedule_styles;

DROP TABLE IF EXISTS schedules;

DROP TABLE IF EXISTS styles;

DROP TABLE IF EXISTS facilities;

DROP TABLE IF EXISTS aufgussers;

DROP TABLE IF EXISTS users;

DROP TABLE IF EXISTS reactions;

SET FOREIGN_KEY_CHECKS = 1;

-- ===============================================
-- テーブルの作成
-- ===============================================

-- ユーザー
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    role ENUM(
        'GENERAL',
        'AUFGUSSER',
        'ADMIN'
    ) NOT NULL DEFAULT 'GENERAL',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- アウフギーサー
CREATE TABLE aufgussers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    home_sauna VARCHAR(255),
    image_url VARCHAR(255),
    introduction TEXT,
    FOREIGN KEY (user_id) REFERENCES users (id)
);

-- 施設
CREATE TABLE facilities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    prefecture VARCHAR(20) NOT NULL,
    address VARCHAR(255),
    website_url VARCHAR(255)
);

-- スタイルタグ
CREATE TABLE styles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    color VARCHAR(20) NOT NULL
);

-- リアクションスタンプ
CREATE TABLE reactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    label VARCHAR(50) NOT NULL UNIQUE,
    icon_url VARCHAR(255) NOT NULL
);

-- イベントスケジュール
CREATE TABLE schedules (
    id INT AUTO_INCREMENT PRIMARY KEY,
    aufgusser_id INT NOT NULL,
    facility_id INT NOT NULL,
    event_datetime DATETIME NOT NULL,
    gender_limit ENUM('MALE', 'FEMALE', 'MIXED') NOT NULL DEFAULT 'MALE',
    reservation_type ENUM('NONE', 'BOOKING', 'LOTTERY') NOT NULL DEFAULT 'NONE',
    price INT DEFAULT 0,
    reservation_url VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (aufgusser_id) REFERENCES aufgussers (id),
    FOREIGN KEY (facility_id) REFERENCES facilities (id)
);

-- 中間テーブル（スケジュール ⇔ スタイル）
CREATE TABLE schedule_styles (
    schedule_id INT NOT NULL,
    style_id INT NOT NULL,
    PRIMARY KEY (schedule_id, style_id),
    FOREIGN KEY (schedule_id) REFERENCES schedules (id),
    FOREIGN KEY (style_id) REFERENCES styles (id)
);

-- 感想
CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    schedule_id INT NOT NULL,
    reaction_id INT NOT NULL,
    comment TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (schedule_id) REFERENCES schedules (id),
    FOREIGN KEY (reaction_id) REFERENCES reactions (id)
);