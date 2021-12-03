# README

# README

# Github link: https://github.com/Rhett-Williams/Marketplace_app.git


# Heroku link: https://givememoney.herokuapp.com/


# Identification of the problem you are trying to solve by building this particular marketplace app:

Alot of people need money for various reasons. Some people have a great idea that needs funding. Other people need money for food because they are homeless. Either way, a platform in which individuals are able to request money from strangers for various reasons is a great way to help people.
That is exactly what this website will do. It will give individuals the ability to request an amount of money from people, provide a reason so people are able to decide whether they want to donate, then instantly connect and gain the ability to transfer funds directly to them.
currently, there are websites that allow you to do this but can often take a hefty percentage of the trade and can be problematic to authorise an account and payment system.

# Why is it a problem that needs solving:

- There are people who need money using other methodsto get it
- charities often take a large quantity off the top

# Description of your marketplace app (website), including:
- Purpose
    to connect individuals who need money to people who want todonate money
- Functionality / features
    - users can view other peoples money requests
    - users can post their own requests for money
    - the requests for money will have a donation amount which they would like to recieve, an image upload ability which they can provide as relevant to their situation
    - users will also be able to manage their own requests for funds and either edit, show or delete them if necessary
    - users will also be able to delete their account should they choose
    - while users will be able to view other users posts, they will not be able to delete or edit other users posts.
- Sitemap

- Screenshots

- Target audience
    The target audience of this web app is firstyl, the users who will be of many different age ranges and ethnicitys, likely the majority from lower socioeconomic areas and younger ages (uni students). The donators of the app will be anyone, not necessary wealthy people as individuals who want to support a good cause will also be donators.

- Tech stack (e.g. html, css, deployment platform, etc)
    - languages:
        HTML
        CSS
        Ruby
    - Frameworks:
        Bootstrap
        Ruby on Rails
    - Databases:
        PostgreSQL
# User stories for your app:
    - Donator:
        - I want to be able to help people in need
        - I want a simple platform for donating to people in need
        - I wantto beable to edit and delete my profile
    - Reciever:
        - I want to be able to request money form many users
        - I want to be able to display a photo related to my situation
        - I want to be able to edit and delete my posts
        - I wantto be able to edit and delete my profile
# Wireframes for your app
  Wireframes in Photos Folder

# An ERD for your app

# Explain the different high-level components (abstractions) in your app
- This is an MVC application, therefore in the user
# Detail any third party services that your app will use
    - Bootstrap
    - Stripe
    - Heroku
    - Github
    - Digital Ocean
# Describe your projects models in terms of the relationships (active record associations) they have with each other
# Discuss the database relations to be implemented in your application
 - User:
    has_many :requests
        - The user accounts will be able to create multiple requests
        - The user account will have a name, email, user id, password
        - The user will be able to edit and delete their own accounts but will not be able to manipulate other user's accounts
 - Requests:
    belongs_to :user
    has_one_attached :image
        - The image attached to the request will be able to be viewed by all users
        - the requests will belong to a user and hence will only be able to be edited or destroyed by the user who owns the request.
        - It belongs to a user by the user ID.
# Provide your database schema design

ActiveRecord::Schema.define(version: 2021_12_02_022144) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "installs", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_installs_on_email", unique: true
    t.index ["reset_password_token"], name: "index_installs_on_reset_password_token", unique: true
  end

  create_table "pay_charges", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "subscription_id"
    t.string "processor_id", null: false
    t.integer "amount", null: false
    t.string "currency"
    t.integer "application_fee_amount"
    t.integer "amount_refunded"
    t.jsonb "metadata"
    t.jsonb "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id", "processor_id"], name: "index_pay_charges_on_customer_id_and_processor_id", unique: true
    t.index ["subscription_id"], name: "index_pay_charges_on_subscription_id"
  end

  create_table "pay_customers", force: :cascade do |t|
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "processor", null: false
    t.string "processor_id"
    t.boolean "default"
    t.jsonb "data"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_type", "owner_id", "deleted_at", "default"], name: "pay_customer_owner_index"
    t.index ["processor", "processor_id"], name: "index_pay_customers_on_processor_and_processor_id", unique: true
  end

  create_table "pay_merchants", force: :cascade do |t|
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "processor", null: false
    t.string "processor_id"
    t.boolean "default"
    t.jsonb "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_type", "owner_id", "processor"], name: "index_pay_merchants_on_owner_type_and_owner_id_and_processor"
  end

  create_table "pay_payment_methods", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.string "processor_id", null: false
    t.boolean "default"
    t.string "type"
    t.jsonb "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id", "processor_id"], name: "index_pay_payment_methods_on_customer_id_and_processor_id", unique: true
  end

  create_table "pay_subscriptions", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.string "name", null: false
    t.string "processor_id", null: false
    t.string "processor_plan", null: false
    t.integer "quantity", default: 1, null: false
    t.string "status", null: false
    t.datetime "trial_ends_at"
    t.datetime "ends_at"
    t.decimal "application_fee_percent", precision: 8, scale: 2
    t.jsonb "metadata"
    t.jsonb "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id", "processor_id"], name: "index_pay_subscriptions_on_customer_id_and_processor_id", unique: true
  end

  create_table "pay_webhooks", force: :cascade do |t|
    t.string "processor"
    t.string "event_type"
    t.jsonb "event"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "requests", force: :cascade do |t|
    t.string "display_name"
    t.string "reason"
    t.integer "dollar_amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "uid"
    t.string "provider"
    t.string "access_code"
    t.string "publishable_key"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "pay_charges", "pay_customers", column: "customer_id"
  add_foreign_key "pay_charges", "pay_subscriptions", column: "subscription_id"
  add_foreign_key "pay_payment_methods", "pay_customers", column: "customer_id"
  add_foreign_key "pay_subscriptions", "pay_customers", column: "customer_id"
end