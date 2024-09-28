import 'package:flutter/material.dart';

import '../../models/pokemon_model.dart';
import '../../repositories/pokemon_repository.dart';
import '../details/pokemon_detail_page.dart';
import 'widgets/pokemon_card.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  var loading = true;
  var pokemons = <PokemonModel>[];
  final pokemonRepository = PokemonRepository();

  @override
  void initState() {
    super.initState();

    pokemonRepository.getAll().then((result) {
      pokemons = result;
      loading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: loading
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomScrollView(
                  slivers: [
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (_, index) {
                          final pokemon = pokemons[index];
                          return PokemonCard(pokemon, onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PokemonDetailPage(
                                  pokemons: pokemons,
                                  selectedPokemon: pokemon,
                                ),
                              ),
                            );
                          });
                        },
                        childCount: pokemons.length,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
