# テーブル設計

## users

| Column   | Type    | Options     |
| -------- | ------- | ----------- |
| nickname | string  | null: false |
| email    | string  | null: false |
| password | string  | null: false |

### Association
- has_many :items
- has_many :orders
- has_one :profile

## items

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| image        |            | null: false                    |
| title        | string     | null: false                    |
| explanation  | text       | null: false                    |
| category     | string     | null: false                    |
| status       | string     | null: false                    |
| transfer_fee | string     | null: false                    |
| from_address | string     | null: false                    |
| delivery_day | string     | null: false                    |
| price        | integer    | null: false                    |
| user         | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order

## orders

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :toAddress

## profiles

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| first_name | string     | null: false                    |
| last_name  | string     | null: false                    |
| birthday   | integer    | null: false                    |
| user       | references | null: false, foreign_key: true |

### Association
- belongs_to :user

## toAddress

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| zip_code      | string     | null: false                    |
| prefecture    | string     | null: false                    |
| city          | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | integer    | null: false                    |
| order         | references | null: false, foreign_key: true |

### Association
- belongs_to :order