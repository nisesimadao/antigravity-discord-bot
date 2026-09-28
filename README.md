<div align="center">

![Header Image](header.jpg)

# Antigravity Discord Bot

<img src="https://img.shields.io/badge/Node.js-18.x+-43853D?style=for-the-badge&logo=nodedotjs&logoColor=white" alt="Node.js" />
<img src="https://img.shields.io/badge/Discord.js-14.x-5865F2?style=for-the-badge&logo=discord&logoColor=white" alt="Discord.js" />
<img src="https://img.shields.io/badge/WebSocket-WS-000000?style=for-the-badge" alt="WebSocket" />
<img src="https://img.shields.io/badge/Chokidar-5.x-blue?style=for-the-badge" alt="Chokidar" />

</div>

Antigravity（VS Code Fork）を Discord から操作するための非公式ボットです。Chrome DevTools Protocol（CDP）で Antigravity の内部状態にアクセスし、メッセージ送信や各種操作を行います。

> ※ 本ツールは公式の Antigravity とは無関係です。

> [!CAUTION]
> **【重要】セキュリティに関する警告 / Security Warning**
>
> このソフトウェアは、**開発者向けの実験的な Proof of Concept** です。仕組み上、Discord を経由して PC 上の AI エージェントを遠隔操作できるため、設定を誤ると第三者に PC を操作される危険があります。
>
> - **リスク**: `DISCORD_ALLOWED_USER_ID` の設定ミスや Bot トークンの漏洩により、PC 内のファイルを削除されたり、意図しないコマンドを実行されたりする可能性があります。
> - **免責事項**: 本ソフトウェアの利用によって生じたデータ損失、PC の不具合、セキュリティ被害などについて、作者は責任を負いません。リスクを理解したうえで使用してください。
> - **非推奨**: セキュリティ知識のない利用者への配布や、不特定多数が閲覧できる場所への Bot トークン公開は行わないでください。

## ⚠️ セキュリティについて（必読）

この Bot から操作する AI エージェントは、ファイルの読み書きやコマンド実行ができます。そのため、Bot の操作権限を第三者に奪われると、PC 自体を操作される可能性があります。

安全に使うため、次の点を守ってください。

1. **`.env` を公開しない**: `DISCORD_BOT_TOKEN` はパスワードと同様に扱ってください。
2. **`DISCORD_ALLOWED_USER_ID` を正しく設定する**: 許可するユーザー ID は自分だけに限定してください。v1.1 以降は、未設定のままでは起動しません。
3. **信頼できるネットワークで使用する**: 公衆無線 LAN など、盗聴リスクの高い環境での利用は避けてください。
4. **独立した環境で使用する**: 事故に備え、普段使いの PC ではなく、個人情報を保存していない PC や仮想環境での利用を推奨します。

## おすすめの導入方法

Antigravity の AI チャットに、次のプロンプトを入力します。

> https://github.com/harunamitrader/antigravity-discord-bot を導入して。可能な範囲でAI側で作業を行い、必要な情報があれば質問して。手動で行う必要があるものは丁寧にやり方を教えて。

導入後、必要であれば次のプロンプトも送信します。

> デバッグモード用ショートカットとantigravity-discord-botの起動用ショートカットをデスクトップに作成して

導入中に不明点やエラーが出た場合は、その内容を Antigravity の AI チャットに伝えて確認してください。

許可ボタン周辺の自動化が必要な場合は、拡張機能 **Antigravity Auto Accept** を導入し、`AUTO ACCEPT` を有効にできます。ただし、確認操作を省略する機能なので、利用時は実行内容を十分に確認してください。

## 🚀 主な機能

1. **テキスト生成**: Discord のメッセージを Antigravity に転送し、生成を開始します。
2. **ファイル添付**: 画像やテキストファイルを添付して Antigravity に送信できます。
3. **モデル切替**: `/model` コマンドで AI モデルを切り替えられます。
4. **モード切替**: `/mode` コマンドで Planning / Fast モードを切り替えられます。
5. **スクリーンショット**: `/screenshot` コマンドで現在の画面を取得できます。
6. **生成停止**: `/stop` コマンドで生成を中断できます。
7. **新規チャット**: `/newchat` コマンドで新しい会話を開始できます。
8. **ファイル監視**: プロジェクトディレクトリ内のファイル変更を検知し、Discord に通知します。

## 🛠️ 事前準備（Discord Bot の作成）

### 1. Discord Bot の作成とトークン取得

1. [Discord Developer Portal](https://discord.com/developers/applications) にアクセスし、ログインします。
2. 右上の **"New Application"** をクリックし、名前（例: `AntigravityBot`）を入力して作成します。
3. 左メニューの **"Bot"** を選択し、**"Reset Token"** をクリックしてトークンを生成・コピーします。
   - このトークンを `.env` の `DISCORD_BOT_TOKEN` に設定します。
4. 同じ Bot タブ下部の **"Privileged Gateway Intents"** で、次の項目を **ON** にします。
   - **PRESENCE INTENT**
   - **SERVER MEMBERS INTENT**
   - **MESSAGE CONTENT INTENT**（メッセージの読み取りに必要）
5. 設定を変更したら、**Warning: Save Changes** ボタンで保存します。

### 2. Bot をサーバーに招待

1. 左メニューの **"OAuth2"** → **"URL Generator"** を選択します。
2. **SCOPES** で `bot` にチェックを入れます。
3. **BOT PERMISSIONS** で、最低限次の権限を有効にします。
   - Read Messages/View Channels
   - Send Messages
   - Send Messages in Threads
   - Embed Links
   - Attach Files
   - Read Message History
4. 生成された URL をブラウザで開き、Bot を自分のサーバーに追加します。

### 3. Discord ユーザー ID の取得

1. Discord アプリの **「ユーザー設定」**（歯車アイコン）→ **「詳細設定」** を開きます。
2. **「開発者モード」** をオンにします。
3. 自分のユーザーアイコンまたは名前を右クリックし、**「ユーザー ID をコピー」** を選択します。
   - この ID を `.env` の `DISCORD_ALLOWED_USER_ID` に設定します。

## 📦 導入方法

### 必要要件

- Node.js（v18 以上推奨）
- Antigravity（デバッグポート `9222` で起動していること）

### インストール手順

1. リポジトリをクローンします。

   ```bash
   git clone https://github.com/harunamitrader/antigravity-discord-bot.git
   cd antigravity-discord-bot
   ```

2. 依存パッケージをインストールします。

   ```bash
   npm install
   ```

3. 環境変数を設定します。リポジトリ内の `.env.example` を `.env` としてコピーし、必要な値を入力してください。

   **Windows（PowerShell）:**

   ```powershell
   cp .env.example .env
   ```

   **Mac / Linux:**

   ```bash
   cp .env.example .env
   ```

### 起動方法

1. **Antigravity をデバッグモードで起動**
   - Antigravity のショートカットをコピーします。
   - ショートカットを右クリックして **「プロパティ」** を開きます。
   - **「リンク先」** の末尾に半角スペースを入れ、`--remote-debugging-port=9222` を追加します。
     - 例: `"C:\...\Antigravity.exe" --remote-debugging-port=9222`
   - 「OK」で保存し、そのショートカットから Antigravity を起動します。

2. **Bot を起動**

   ```bash
   node discord_bot.js
   ```

## 📖 コマンド一覧

| コマンド | 説明 |
|---|---|
| `/help` | コマンド一覧を表示 |
| `/status` | モデルとモードの状態を表示 |
| `/model` | 利用可能なモデル一覧を表示 |
| `/model <番号>` | 指定したモデルに切り替える |
| `/mode` | 現在のモードを表示 |
| `/mode <planning/fast>` | モードを切り替える |
| `/title` | チャットタイトルを表示 |
| `/newchat` | 新しいチャットを開始 |
| `/stop` | 生成を停止 |
| `/screenshot` | スクリーンショットを取得 |

## 🛠️ 技術仕様

詳細は [SPECIFICATION.md](SPECIFICATION.md) を参照してください。

## 📜 ライセンス

MIT License
