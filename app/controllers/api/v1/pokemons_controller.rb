module Api
    module V1
        class PokemonsController < ApplicationController
            def index
                pokemons = Pokemon.order('id');
                render json: {
                    status: 'Success',
                    message: 'All Pokemons',
                    data: pokemons
                }, status: :ok
            end

            def show
                pokemon = Pokemon.find(params[:id]);
                render json: {
                    status: 'Success',
                    message: 'Pokemon by id',
                    data: pokemon
                }, status: :ok
            end

            def create
                pokemon = Pokemon.new(pokemon_params);
                if pokemon.save
                    render json: {
                        status: 'Success',
                        message: 'Pokemon Created',
                        data: pokemon
                    }, status: :ok
                else
                    render json: {
                        status: 'Success',
                        message: 'Pokemon no Created',
                        data: pokemon
                    }, status: :unprocessable_entity
                end
            end

            def destroy
                pokemon = Pokemon.find(params[:id]);
                if pokemon.destroy
                    render json: {
                        status: 'Success',
                        message: 'Pokemon destroyed',
                        data: pokemon
                    }, status: :ok
                else
                    render json: {
                        status: 'Success',
                        message: 'Pokemon no destroyed',
                        data: pokemon
                    }, status: :unprocessable_entity
                end
            end

            def update
                pokemon = Pokemon.find(params[:id]);
                if pokemon.update(pokemon_params)
                    render json: {
                        status: 'Success',
                        message: 'Pokemon updated',
                        data: pokemon
                    }, status: :ok
                else
                    render json: {
                        status: 'Success',
                        message: 'Pokemon no updated',
                        data: pokemon
                    }, status: :unprocessable_entity
                end
            end

            private

            def pokemon_params
                params.permit(:name, :type_one, :type_two,
                    :total, :hp, :attack, :defense, :sp_atk,
                    :sp_def, :speed, :generation, :legendary)
            end
            
        end
    end
end