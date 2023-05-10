# テーブル設計

## users テーブル

| Column             | Type     | Options                       |
| ------------------ | -------- | ----------------------------- |
| username           | string   | null: false                   |
| email              | string   | null: false unique: true      |
| password_digest    | string   | null: false                   |
| name               | string   | null: false                   |
| name_kana          | string   | null: false                   |
| birth_date         | date     | null: false                   |


### Association

- has_many :items, dependent: :destroy
- has_many :purchases, dependent: :destroy

## items テーブル

| Column             | Type        | Options                       |
| ------------------ | ----------- | ----------------------------- |
| user               | references  | null: false foreign_key: true |
| item_name          | string      | null: false                   |
| description        | text        | null: false                   |
| price              | integer     | null: false                   |
| condition          | integer     | null: false                   |
| category           | integer     | null: false                   |
| delivery_fee       | integer     | null: false                   |
| delivery_day       | integer     | null: false                   |
| prefecture         | integer     | null: false                   |

### Association

- belongs_to :user
- has_one :purchases, dependent: :destroy

## purchases テーブル

| Column             | Type        | Options                       |
| ------------------ | ----------- | ----------------------------- |
| user               | references  | null: false foreign_key: true |
| item               | references  | null: false foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## shippings テーブル

| Column             | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| postal_code        | string     | null: false                   |
| prefecture         | integer    | null: false                   |
| city               | string     | null: false                   |
| address            | string     | null: false                   |
| building_name      | string     |                               |
| phone_number       | string     | null: false                   |
| purchase           | references | null: false foreign_key: true |

### Association

- belongs_to :purchase