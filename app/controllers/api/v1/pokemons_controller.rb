module Api
    module V1
        class PokemonsController < ApplicationController
            require 'will_paginate/array'
            require "csv"
            def index
                #get data from csv
                pokemonsTmp = handlerCSV();

                #Pokemon.all.each do |pokemon|
                #    pokemons.push(pokemon)
                #end
                pokemons = pokemonsTmp.paginate(page: params[:page], per_page: 10);

                render json: {
                    status: 'Success',
                    message: 'Page Pokemons',
                    data: pokemons
                }, status: :ok

            end

            def show
                #pokemon = Pokemon.find(params[:id]);
                pokemonsTmp = handlerCSV();
   
                pokemons = pokemonsTmp.find_all { |data| data.id == params[:id].to_i }
                render json: {
                    status: 'Success',
                    message: 'Pokemon by id',
                    data: pokemons
                }, status: :ok

            end

            def create
                pokemon = Pokemon.new(pokemon_params);
               
                columns = [ 'id', 'name', 'type_one', 'type_two',
                        'total', 'hp', 'attack', 'defense',
                        'sp_atk', 'sp_def', 'speed', 'generation',
                        'legendary' ]

                csv_text = File.read(Rails.root.join("lib", "csvs", "pokemon.csv"))
                csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
                    
                CSV.open(Rails.root.join("lib", "csvs", "pokemon.csv"), "a") do |csv|
                    row_str = []
                    columns.each do |attr_name|
                        row_str.push(pokemon[attr_name]) 
                    end 
                    csv << row_str
                end

                render json: {
                    status: 'Success',
                    message: 'Pokemon Created',
                    data: pokemon
                }, status: :ok

            
                #pokemon = Pokemon.new(pokemon_params);
                #if pokemon.save
                #    render json: {
                #        status: 'Success',
                #        message: 'Pokemon Created',
                #        data: pokemon
                #    }, status: :ok
                #else
                #    render json: {
                #        status: 'Success',
                #        message: 'Pokemon no Created',
                #        data: pokemon
                #    }, status: :unprocessable_entity
                #end 
    
            end

            def destroy
                
                csv_text = File.read(Rails.root.join("lib", "csvs", "pokemon.csv"))
                csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
      
                dataSelected = csv.select{ |row| row['#'] == params[:id]}
                pokemons = []
                dataSelected.each do |row| 
                    pokemons.push(getPokemon(row))
                end  
  
                if pokemons.size > 0
                    csv.delete_if do |row|
                        row['#'] == params[:id]
                    end
                
                    File.open(Rails.root.join("lib", "csvs", "pokemon.csv"), 'w') do |f|
                        f.write(csv)
                    end
                    render json: {
                        status: 'Success',
                        message: 'Pokemon destroyed',
                        data: pokemons
                    }, status: :ok
                else
                    render json: {
                        status: 'Success',
                        message: 'Pokemon no found',
                        data: []
                    }, status: :unprocessable_entity
                end

                #pokemon = Pokemon.find(params[:id]);
                #if pokemon.destroy
                #    render json: {
                #        status: 'Success',
                #        message: 'Pokemon destroyed',
                #        data: pokemon
                 #   }, status: :ok
                #else
                #    render json: {
                #        status: 'Success',
                #        message: 'Pokemon no destroyed',
                #        data: pokemon
                #    }, status: :unprocessable_entity
                #end
            end

            def update
                csv_text = File.read(Rails.root.join("lib", "csvs", "pokemon.csv"))
                csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
      
                dataSelected = csv.select{ |row| row['#'] == params[:id]}
                pokemons = []
                dataSelected.each do |row| 
                    pokemons.push(getPokemon(row))
                end  

                if pokemons.size > 0
                    
                    pokemonsTmp = Pokemon.new(pokemon_params);

                    pokemonsTmp.attributes.each do |attr_name, attr_value|
                        if pokemonsTmp[attr_name].present?
                            pokemons[0][attr_name] = attr_value
                        end
                    end

                    csv.delete_if do |row|
                        row['#'] == params[:id]
                    end
                
                    File.open(Rails.root.join("lib", "csvs", "pokemon.csv"), 'w') do |f|
                        f.write(csv)
                    end

                    columns = [ 'id', 'name', 'type_one', 'type_two',
                    'total', 'hp', 'attack', 'defense',
                    'sp_atk', 'sp_def', 'speed', 'generation',
                    'legendary' ]

                    CSV.open(Rails.root.join("lib", "csvs", "pokemon.csv"), "a") do |csv|
                        row_str = []
                        columns.each do |attr_name|
                            row_str.push(pokemons[0][attr_name]) 
                        end 
                        csv << row_str
                    end

                    render json: {
                        status: 'Success',
                        message: 'Pokemon udated',
                        data: [pokemons[0]]
                    }, status: :ok
                else
                    render json: {
                        status: 'Success',
                        message: 'Pokemon no found',
                        data: []
                    }, status: :unprocessable_entity
                end


                #pokemon = Pokemon.find(params[:id]);
                #if pokemon.update(pokemon_params)
                #    render json: {
                #        status: 'Success',
                #        message: 'Pokemon updated',
                #        data: pokemon
                #    }, status: :ok
                #else
                #    render json: {
                #        status: 'Success',
                #        message: 'Pokemon no updated',
                #        data: pokemon
                #    }, status: :unprocessable_entity
                #end
            end

            private

            def pokemon_params
                params.permit(:id, :name, :type_one, :type_two,
                    :total, :hp, :attack, :defense, :sp_atk,
                    :sp_def, :speed, :generation, :legendary)
            end

            def handlerCSV()
                pokemons = []
                csv_text = File.read(Rails.root.join("lib", "csvs", "pokemon.csv"))
                csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
                csv.each do |row|
                    pokemons.push(getPokemon(row))
                end       
                return pokemons
            end
            
            def getPokemon(row)
                t = Pokemon.new
                t.id = row['#']
                t.name = row['Name']
                t.type_one = row['Type 1']
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
                return t
            end
        end
    end
end
