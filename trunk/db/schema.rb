# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 7) do

  create_table "banned_ips", :force => true do |t|
    t.column "ip",        :string
    t.column "reason",    :string
    t.column "banned_by", :integer
    t.column "ban_time",  :datetime
  end

  create_table "edits", :force => true do |t|
    t.column "text",    :text
    t.column "version", :integer
    t.column "user_id", :integer
    t.column "post_id", :integer
  end

  create_table "forums", :force => true do |t|
    t.column "title",       :string
    t.column "description", :text
  end

  create_table "posts", :force => true do |t|
    t.column "text",       :text
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "user_id",    :integer
    t.column "topic_id",   :integer
  end

  create_table "topics", :force => true do |t|
    t.column "forum_id",   :integer
    t.column "subject",    :string
    t.column "user_id",    :integer
    t.column "created_at", :datetime
    t.column "locked",     :boolean
    t.column "views",      :integer
  end

  create_table "users", :force => true do |t|
    t.column "login",                     :string
    t.column "email",                     :string
    t.column "crypted_password",          :string,   :limit => 40
    t.column "salt",                      :string,   :limit => 40
    t.column "created_at",                :datetime
    t.column "updated_at",                :datetime
    t.column "remember_token",            :string
    t.column "remember_token_expires_at", :datetime
    t.column "previous_login",            :datetime
    t.column "admin",                     :boolean
    t.column "signature",                 :string
    t.column "login_time",                :datetime
    t.column "banned_by",                 :integer
    t.column "ban_time",                  :datetime
    t.column "ban_reason",                :string
    t.column "ban_times",                 :integer
  end

end
