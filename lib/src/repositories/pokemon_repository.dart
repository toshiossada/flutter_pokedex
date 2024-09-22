import 'package:dio/dio.dart';

class PokemonRepository {
  final client = Dio();
  getAll() async {
    final response =
        await client.get('https://pokeapi.co/api/v2/pokemon?limit=151');
    final pokemons = response.data['results'] as List<Map<String, dynamic>>;

    const futures = <Future<Response<dynamic>>>[];
    for (var element in pokemons) {
      futures.add(client.get('https://pokeapi.co/api/v2/pokemon?limit=151'));
    }

    Future.wait(futures).then((List<Response<dynamic>> responses) {

    });
  }
}
