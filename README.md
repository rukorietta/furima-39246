# テーブル設計

## users テーブル

| Column             | Type     | Options                       |
| ------------------ | -------- | ----------------------------- |
| id                 | integer  | null: false primary_key: true |
| username           | string   | null: false unique: true      |
| email              | string   | null: false                   |
| address            | string   | null: false unique: true      |
| phone_number       | string   | null: false                   |
| created_at         | datetime | null: false                   |
| updated_at         | datetime | null: false                   |

### Association

- has_many :items, dependent: :destroy
- has_many :purchases, dependent: :destroy
- has_one :shipping, dependent: :destroy

## items テーブル

| Column             | Type     | Options                       |
| ------------------ | -------- | ----------------------------- |
| id                 | integer  | null: false primary_key: true |
| user_id            | integer  | null: false foreign_key: true |
| item_name          | string   | null: false                   |
| description        | text     | null: false                   |
| image_url          | string   | null: false                   |
| price              | integer  | null: false                   |
| condition          | string   | null: false                   |
| category           | string   | null: false                   |
| created_at         | datetime | null: false                   |
| updated_at         | datetime | null: false                   |

### Association

- belongs_to :user
- has_many :purchases, dependent: :destroy

## purchases テーブル

| Column             | Type     | Options                       |
| ------------------ | -------- | ----------------------------- |
| id                 | integer  | null: false primary_key: true |
| user_id            | integer  | null: false foreign_key: true |
| item_id            | integer  | null: false foreign_key: true |
| purchased_at       | datetime | null: false                   |
| quantity           | integer  | null: false                   |
| total_price        | integer  | null: false                   |
| status             | string   | null: false                   |
| created_at         | datetime | null: false                   |
| updated_at         | datetime | null: false                   |

### Association

- belongs_to :user
- belongs_to :item

## shippings テーブル

| Column             | Type     | Options                       |
| ------------------ | -------- | ----------------------------- |
| id                 | integer  | null: false primary_key: true |
| user_id            | integer  | null: false foreign_key: true |
| recipient_name     | string   | null: false                   |
| address            | string   | null: false                   |
| phone_number       | string   | null: false                   |
| created_at         | datetime | null: false                   |
| updated_at         | datetime | null: false                   |

### Association

- belongs_to :user
