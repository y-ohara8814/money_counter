# ポートフォリオ
Atonanbo

https://atonanbo.herokuapp.com/users/sign_in

※「ゲストログイン」ボタンで、ユーザー登録せずアプリケーションを利用できます

# 動作デモ

![result (1)](https://user-images.githubusercontent.com/41667847/95216297-db8d8400-082c-11eb-9539-c8fbf2191173.gif)


# ポートフォリオ概要

複数人でひとつの家計簿を運用するアプリケーションです。
ユーザーはグループに所属し、月ごとにプランを設定します。
プランでは、
- 目標金額（月に幾らまで使えるか、予算のようなもの）
- 利用用途（何に、幾ら使ったかを登録）

を設定/登録していく、という使い方です。

# 特徴
グループには、自分以外の利用者をメンバーとして所属させることができます。
同じ財布を使っている夫婦の家計簿や、ひとつの予算から複数人がお金を使っていくサークルの活動記録、といった運用を想定しています。


# 制作の背景
身近な人の困りごとを解決するツールとして、このアプリケーションを制作しました。
具体的には、妻から「毎月の食費や雑費の支出を、一定金額内に収めたい」という要望があり、
「目標金額はいくらで、誰が、いつ、何にお金を使ったか」を可視化して管理しようという方向性を決めて、
アプリケーションを作成しました。

# 利用技術
## サーバーサイド
* Ruby 2.6.0

* Rails 5.2.4.3

## フロントエンド
* SCSS
* CSSフレームワーク(Semantic UI)
* JavaScript(jQuery)

# 機能一覧
* ユーザー登録機能

→氏名、メールアドレス、パスワードを入力してユーザー登録。以降は、メールアドレス・パスワードでログイン

![サンプル画像](https://user-images.githubusercontent.com/41667847/95087264-6eaab900-075c-11eb-9160-b70e29f4d28d.jpg)


* ユーザーマイページ

→所属しているグループの一覧と、同じグループに所属している他ユーザーの名前を表示

このページから、各グループで作成したプランの詳細画面へ遷移

![サンプル画像](https://user-images.githubusercontent.com/41667847/95087775-12946480-075d-11eb-9554-81f31c26b90f.jpg)



* グループ作成機能

→ログインユーザーが、グループ名と所属メンバー（複数可）を決めて登録する。

 グループ（１）：ユーザー（多）の関係
 
 ![サンプル画像](https://user-images.githubusercontent.com/41667847/94979361-22455a80-055d-11eb-9f4c-d1c5f706c431.jpg)

 
* プラン作成機能

→グループに所属するユーザーが、●年●月に利用可能な金額を設定する。１グループにつき、1件/月まで。

 グループ（１）：プラン（多）の関係
 
 ![スクリーンショット 2020-10-05 22 50 44](https://user-images.githubusercontent.com/41667847/95087935-45d6f380-075d-11eb-8033-915d5fbbc845.jpg)

 
* プラン表示機能

→グループのメインページにおいて、プランの詳細を表示する。具体的には、

 ・今月の利用可能金額
 
 ・利用履歴（後述）
 
 ・利用金額登録フォーム（後述）
 
 を表示する。
 
 ![スクリーンショット 2020-10-05 22 51 57](https://user-images.githubusercontent.com/41667847/95088367-d1508480-075d-11eb-994d-9e198aca11c1.jpg)

![スクリーンショット 2020-10-05 22 54 59](https://user-images.githubusercontent.com/41667847/95088596-1bd20100-075e-11eb-91c8-c74a83be1ca0.jpg)


* 利用金額登録機能

→グループに所属するユーザーが、●月のプランに対して、

　・同月の●日に、
 
　・どの用途で
 
  ・何円使ったか

　を登録する。プラン（１）：利用金額（多）の関係
 
 ![スクリーンショット 2020-10-06 8 35 54](https://user-images.githubusercontent.com/41667847/95142587-fcaf8f80-07ae-11eb-8f04-7f7e341de1fa.jpg)

 
* 利用履歴表示機能
→グループのメインページ内、プランの詳細として表示する。

 ・使用者
 
 ・使用金額
 
 ・用途
 
 ・使用した日

![スクリーンショット 2020-10-06 8 37 53](https://user-images.githubusercontent.com/41667847/95142700-413b2b00-07af-11eb-99c8-70425cc221a0.jpg)
