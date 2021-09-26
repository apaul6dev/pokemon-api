namespace :slurp do
  desc "TODO"
  task transactions: :environment do
    require "csv"
    csv_text = File.read(Rails.root.join('lib', 'csvs', 'pokemon.csv'))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv.each do |row|
      t = Transaction.new
      t.id = row['#']
      t.name = row['Name']
      t.type_onw = row['Type 1']
      t.type_two = row['Type 2']
      t.total = row['Total']
      t.hp = row['HP']
      t.attack = row['Attack']
      t.defense = row['Defense']
      t.sp_atk = row['Sp. Atk']
      t.sp_def = row['Sp. Def']
      t.speed = row['Speed']
      t.generation = row['Generation']
      t.legendary = row['Legendary']
      t.save
      puts "#{t.id}, #{t.name} saved"
    end
    puts "There are now #{Transaction.count} rows in the transactions table"

  end

end
