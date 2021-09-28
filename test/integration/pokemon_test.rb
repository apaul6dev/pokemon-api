require "test_helper"

class PokemonTest < ActionDispatch::IntegrationTest
  test "get pagination" do
    get "/api/v1/pokemons?page=10"
    assert_response :success
  end
end
