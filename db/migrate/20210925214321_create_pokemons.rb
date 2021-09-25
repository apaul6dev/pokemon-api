class CreatePokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons do |t|
      t.decimal :id
      t.string :name
      t.string :type_onw
      t.string :type_two
      t.decimal :total
      t.decimal :hp
      t.decimal :attack
      t.decimal :defense
      t.decimal :sp_atk
      t.decimal :sp_def
      t.decimal :speed
      t.decimal :generation
      t.boolean :legendary

      t.timestamps
    end
  end
end
