# README

This project uses a .CSV file as a database, which can be updated, deleted, created, modified using Api Rest.

if you have problems with the migrations, execute this command: 

rails db:migrate

# pokemon-api


* Get 10 pokemons, page 10

method: get

http://127.0.0.1:3000/api/v1/pokemons?page=10

* get pokemon by id (701)

method: get

http://127.0.0.1:3000/api/v1/pokemons/701


* update register 1

method: put

http://127.0.0.1:3000/api/v1/pokemons/1

Params

{"name": "Bulbasaur" }


* Create new pokemon

method: post

http://127.0.0.1:3000/api/v1/pokemons

Params
	{
        "name": "New Pokemon",
        "id": 1,
        "type_one": "Grass",
        "type_two": "Poison",
        "total": 318,
        "hp": 45,
        "attack": 49,
        "defense": 49,
        "sp_atk": 65,
        "sp_def": 65,
        "speed": 45,
        "generation": 1,
        "legendary": true
 	}

* destroy pokemon 803

method: delete

http://127.0.0.1:3000/api/v1/pokemons/803
