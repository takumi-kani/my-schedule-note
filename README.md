# アプリケーション名
> MyScheduleTable

# 概要
> 大人対子供の間で、連絡帳や交換ノートのような感覚で利用できるように、コミュニケーションを取る目的で作成
- ユーザー及び管理者の新規登録
- 管理者の新規登録及びログイン時のみ、Basic認証を設定
- 新しい予定の作成
- 作成した予定の詳細ページから編集や削除が可能
- その日のイベントに対しての連絡事項や感想など、何でも自由にできるコメント欄
- ユーザーは自分の作成した予定と管理者が作成した予定のみ閲覧可能
- 管理者は自分が作成した予定と全ユーザーの予定が閲覧可能

# 制作背景
> 少年サッカーチームで指導者をしていて、子供たちが自分で活動予定を確認したり、その他にも予定があれば記録できるようなものを作りたいと思った。  
> また、活動を通じて子供たちの考えや意見をより気軽に引き出せるようなコミュニケーションツールがあったらいいな、という思いで作った。  
> 実現できれば他の習い事や学校で先生と生徒のやり取りなど、自分以外の人にとっても活用できそうだと思ったのと、コロナ禍もあり地域・組織によっては対面で話す機会も少ないので時代にも合っているのではないかと思った。


# DEMO
- ログインしていない状態のトップページ  
[![Image from Gyazo](https://i.gyazo.com/1c8186b1d8208c3344394cd0d315e285.png)](https://gyazo.com/1c8186b1d8208c3344394cd0d315e285)
- 新規ユーザー登録  
登録完了後トップページへ遷移  
[![Image from Gyazo](https://i.gyazo.com/71c50881e6479e89f51e3821db7de133.gif)](https://gyazo.com/71c50881e6479e89f51e3821db7de133)
- 管理者の新規登録やログインの際のBasic認証  
[![Image from Gyazo](https://i.gyazo.com/4435554b46efc437dbb9eab27064d02f.png)](https://gyazo.com/4435554b46efc437dbb9eab27064d02f)
- 予定の作成  
[![Image from Gyazo](https://i.gyazo.com/cc1fd6bc3fb431271b58b4c8929e2dc2.gif)](https://gyazo.com/cc1fd6bc3fb431271b58b4c8929e2dc2)
- 詳細ページ  
[![Image from Gyazo](https://i.gyazo.com/289c41a6e724f0bf11e430e82f794d49.png)](https://gyazo.com/289c41a6e724f0bf11e430e82f794d49)
- 田中（ユーザー）視点での予定表  
[![Image from Gyazo](https://i.gyazo.com/932aa37aa2f506896057fa6eb5d202d9.png)](https://gyazo.com/932aa37aa2f506896057fa6eb5d202d9)
- 鈴木（ユーザー）視点での予定表  
[![Image from Gyazo](https://i.gyazo.com/848a766549803273386fabc9c92573c2.png)](https://gyazo.com/848a766549803273386fabc9c92573c2)
- 管理者視点での予定表  
[![Image from Gyazo](https://i.gyazo.com/baf259d3bb77ef8e4739d426547256ac.png)](https://gyazo.com/baf259d3bb77ef8e4739d426547256ac)
- コメント欄  
[![Image from Gyazo](https://i.gyazo.com/e765305ed928a6b8094d850851d0cbcb.png)](https://gyazo.com/e765305ed928a6b8094d850851d0cbcb)

# 今後実装予定の機能
- ビューを見やすくする（子供目線で）
- コメントの非同期通信
- 管理者の作成した予定にもログインしているユーザーと管理者のコメントのみの表示
- ユーザー及び管理者情報の変更や削除
- 祝日の表示
- 写真や動画の投稿
- 管理者が選択したユーザーの予定のみを表示
- 新着コメントがあった時にポップのようなものを表示
- エラーメッセージの編集（子供目線で）

# テーブル設計

## users テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| name               | string  | null: false |
| encrypted_password | string  | null: false |

### Association

- has_many :schedules
- has_many :comments


## admin_users テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| name               | string  | null: false |
| encrypted_password | string  | null: false |

### Association

- has_many :schedules
- has_many :comments


## schedules テーブル

| Column     | Type       | Options           |
| ---------- | ---------- | ----------------- |
| title      | string     | null: false       |
| start_time | time       | null: false       |
| end_time   | time       | null: false       |
| place      | string     | null: false       |
| info       | text       | null: false       |
| user       | references | foreign_key: true |
| admin_user | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :admin_user
- has_one :comments


## comments テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| text       | text       | null: false                    |
| user       | references | foreign_key: true              |
| admin_user | references | foreign_key: true              |
| schedule   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :admin_user
- belongs_to :schedule