class CreateMessageTags < ActiveRecord::Migration
  def change
    create_table :message_tags do |t|
      t.string :tag,   null: false

      t.timestamps null: false
    end
  end
end
