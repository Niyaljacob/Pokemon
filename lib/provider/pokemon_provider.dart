import 'package:flutter/material.dart';
import 'package:pokemon/model/pokemon_model.dart';
import 'package:pokemon/service/pokemon_servise.dart';


class PokemonProvider extends ChangeNotifier {
  List<Pokemon> _pokemons = [];
  List<Pokemon> _filteredPokemons = [];
  bool _loading = false;

  List<Pokemon> get pokemons => _filteredPokemons.isEmpty ? _pokemons : _filteredPokemons;
  bool get loading => _loading;

  Future<void> fetchPokemons() async {
    _loading = true;
    notifyListeners();

    try {
      _pokemons = await PokemonService().fetchPokemons();
      _filteredPokemons = _pokemons; // Initially, display all Pokémon
    } catch (e) {
      _pokemons = [];
      _filteredPokemons = [];
    }

    _loading = false;
    notifyListeners();
  }

  // Search Pokémon by name or ID
  void filterPokemons(String query) {
    if (query.isEmpty) {
      _filteredPokemons = _pokemons; // Reset the filter if the query is empty
    } else {
      _filteredPokemons = _pokemons
          .where((pokemon) =>
              pokemon.name.toLowerCase().contains(query.toLowerCase()) ||
              pokemon.id.toString().contains(query))
          .toList();
    }
    notifyListeners();
  }

  // Filter Pokémon by color
  void filterPokemonsByColor(String color) {
    if (color == 'All') {
      _filteredPokemons = _pokemons;
    } else {
      _filteredPokemons = _pokemons
          .where((pokemon) => pokemon.color.toLowerCase() == color.toLowerCase())
          .toList();
    }
    notifyListeners();
  }
}
