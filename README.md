# データベース設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|icon|string||
|profile|text||

### Association
- has_one :personal_information
- has_many :items
- has_many :credit_cards, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_one :user_evaluation, dependent: :destroy
- has_many :buyers

## personal_informationsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birth|date|null: false|
|postal_code|string|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|address|string|null: false|
|building_name|string||
|phone_number|integer||

### Association
- belongs_to :user

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|name|string|null: false|
|description|text||
|category_id|references|null: false, foreign_key: true|
|size_id|integer||
|brand_id|references|foreign_key: true|
|condition_id|integer|null: false|
|postage_id|integer|null: false|
|area_id|integer|null: false|
|shipping_date_id|integer|null: false|
|price|integer|null: false|
|status_id|integer|null: false|

### Association
- belongs_to :user
- belongs_to :category
- belongs_to :brand
- has_many :item_images, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_one :buyer, dependent: :destroy

## item_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|references|null: false, foreign_key: true|
|image|string|null: false|

### Association
- belongs_to :item

## credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|number|integer|null: false, unique: true|
|month|integer|null: false|
|year|integer|null: false|
|security_code|integer|null: false|

### Association
- belongs_to :user

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item

## user_evaluationsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|good|integer|null: false|
|normal|integer|null: false|
|bad|integer|null: false|

### Association
- belongs_to :user

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|

### Association
- has_many :items

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|path|string||

### Association
- has_many :items

## buyersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item
