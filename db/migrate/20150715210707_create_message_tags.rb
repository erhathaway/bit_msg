class CreateMessageTags < ActiveRecord::Migration
  def change
    create_table :message_tags do |t|
      t.string :tag,   null:false, unique: true

      t.timestamps null: false
    end
  end
end
