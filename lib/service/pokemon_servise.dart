import 'package:dio/dio.dart';
import 'package:pokemon/model/pokemon_model.dart';

class PokemonService {
  final Dio dio = Dio();

  Future<List<Pokemon>> fetchPokemons() async {
    try {
      final response = await dio.get('https://pokeapi.co/api/v2/pokemon?limit=20');
      List<Pokemon> pokemons = [];
      
      for (var pokemon in response.data['results']) {
        final detailsResponse = await dio.get(pokemon['url']);
        final speciesResponse = await dio.get(detailsResponse.data['species']['url']);
        
        final pokemonData = Pokemon.fromJson({
          ...detailsResponse.data,
          'species': speciesResponse.data
        });
        
        pokemons.add(pokemonData);
      }
      
      return pokemons;
    } catch (e) {
      throw Exception('Failed to load Pokémon');
    }
  }
}
