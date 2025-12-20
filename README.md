# 🍃 Aogu (アオグ)

![Java](https://img.shields.io/badge/Java-17-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Eclipse](https://img.shields.io/badge/IDE-Eclipse-2C2255?style=for-the-badge&logo=eclipse&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

**〜今日、誰の風を受ける？ アウフギーサー特化型検索アプリ〜**

## 📖 概要 (Overview)
「どのサウナに行くか」ではなく、**「誰のアウフグース（熱波）を受けに行くか」** を軸にした検索・記録アプリケーションです。
既存のサウナ検索サービスでは「人」単位でのスケジュール把握が難しかったため、**アウフギーサー（熱波師）を主役にしたデータベース** を設計・開発しました。

## ✨ 特徴 (Features)

### 1. アウフギーサー起点のスケジュール検索
「推し」の熱波師が、いつ・どこの施設で扇ぐのかを一目で確認できます。

### 2. 柔軟なイベント管理
ただの日時だけでなく、アウフグース特有の情報を管理できるようにしています。
* **スタイルタグ:** 「激熱」「メディテーション」「ショー」など、演目の傾向をタグ表示。
* **男女制限:** 「男性限定」「女性限定」「男女共用」をアイコンで分かりやすく表示。
* **予約タイプ:** 「事前予約制」なのか「当日抽選」なのかを明記。

### 3. "感覚"による参加ログ
数値による「1〜5点の評価」ではなく、ポジティブな体験を記録する **「感覚ログ」** を採用しました。
* 「ととのった」「あまみ出た」「最高！」などのスタンプを選択。
* アウフギーサーへのリスペクトを込め、ネガティブな評価が生まれない設計にしています。

## 🛠 使用技術 (Tech Stack)
* **言語:** Java 17
* **データベース:** MySQL 8.0
* **開発環境:** Eclipse IDE
* **バージョン管理:** Git / GitHub

## 📂 ドキュメント (Documents)
設計プロセスを公開しています。

* **[データベース設計図 (ER図)](docs/ER_diagram.md)** Mermaid記法を使用し、正規化を意識したテーブル設計を行いました。

## 🚀 セットアップ (Setup)

1. **データベースの準備**
   MySQLにてデータベースを作成し、以下の順序でSQLを実行してください。
   * `sql/schema.sql` (テーブル作成)
   * `sql/data.sql` (テストデータ投入)

2. **接続設定**
   `src/com/aogu/util/DatabaseUtil.java` の接続情報（ユーザー名・パスワード）をご自身の環境に合わせて変更してください。

3. **実行**
   `src/com/aogu/main/Main.java` を実行すると、コンソールアプリケーションが起動します。

---
Created by [あなたの名前]
