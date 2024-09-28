import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/pokemon_model.dart';

class PokemonRepository {
  final client = Dio();

  Future<List<PokemonModel>> getAll() async {
    final response = await client.get(
        'https://raw.githubusercontent.com/toshiossada/flutter_pokedex/main/assets/pokedex.json');
    var decodedJson = jsonDecode(response.data);
    final pokemons = (decodedJson['pokemon'] as List)
        .map((e) => PokemonModel.fromJson(e))
        .toList();

    return pokemons;
  }
}
