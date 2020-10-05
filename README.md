# テーブル設計

## users

| Column          | Type       | Options     |
| --------------- | ---------- | ----------- |
| nickname        | string     | null: false |
| email           | string     | null: false |
| password        | string     | null: false |
| first_name      | string     | null: false |
| last_name       | string     | null: false |
| read_first_name | string     | null: false |
| read_last_name  | string     | null: false |
| birthday        | date       | null: false |

### Association
- has_many :items
- has_many :orders

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

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| card_number   | integer    | null: false                    |
| month         | integer    | null: false                    |
| year          | integer    | null: false                    |
| security_code | integer    | null: false                    |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :Addresses

## Addresses

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| zip_code       | string     | null: false                    |
| prefecture     | integer    | null: false                    |
| city           | string     | null: false                    |
| address_number | string     | null: false                    |
| building_name  | string     |                                |
| phone_number   | string     | null: false                    |
| order          | references | null: false, foreign_key: true |

### Association
- belongs_to :order