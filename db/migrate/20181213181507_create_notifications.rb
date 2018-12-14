class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.references :item, polymorphic: true, index: true
      t.boolean :viewed, default: false

      t.timestamps
    end
  end
end

=begin
  polymorphic
  me permite almacenar información de distintas tablas
  (posts, friends, users)
  item_type = tabla
  item_id = que elemento de la tabla
=end