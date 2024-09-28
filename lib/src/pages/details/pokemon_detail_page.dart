import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/pokemon_model.dart';
import '../widgets/pokemon_badge_type.dart';

class PokemonDetailPage extends StatefulWidget {
  final List<PokemonModel> pokemons;
  final PokemonModel selectedPokemon;

  const PokemonDetailPage({
    super.key,
    required this.pokemons,
    required this.selectedPokemon,
  });

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  late PokemonModel pokemon = widget.selectedPokemon;
  final pageController = PageController(viewportFraction: 0.5);
  Color get color => pokemon.types.first.color;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      selectedPokemon(widget.selectedPokemon);
    });
  }

  selectedPokemon(PokemonModel pokemon) {
    setState(() {
      this.pokemon = widget.pokemons.firstWhere(
        (element) => element.number == pokemon.number,
      );
      pageController.jumpToPage(
        widget.pokemons.indexOf(this.pokemon),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text('#${pokemon.number} - ${pokemon.name}'),
      ),
      body: Container(
        color: pokemon.types.first.color,
        child: Stack(
          children: [
            Column(
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    color: Colors.white,
                  ),
                  height: MediaQuery.sizeOf(context).height * 0.75,
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Hero(
                              tag: '${pokemon.number}${pokemon.name}',
                              child: Text(
                                pokemon.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                '#${pokemon.number.toString().padLeft(3, '0')}',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          spacing: 15,
                          children: pokemon.types
                              .map(
                                (type) => Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: PokemonBadgeType(
                                    type: type,
                                    fontSize: 22,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Evolutions',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: pokemon.evolutions.length,
                            itemBuilder: (_, index) {
                              final evolution = pokemon.evolutions[index];

                              return GestureDetector(
                                onTap: () {
                                  selectedPokemon(evolution);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: evolution.img,
                                        height: 100,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                      Text(
                                        evolution.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (index) {
                      selectedPokemon(widget.pokemons[index]);
                    },
                    controller: pageController,
                    itemCount: widget.pokemons.length,
                    itemBuilder: (_, index) {
                      final item = widget.pokemons[index];
                      return Hero(
                        tag: '${item.number}${item.name}_image',
                        child: AnimatedPadding(
                          duration: const Duration(milliseconds: 300),
                          padding: EdgeInsets.all(
                            item.number == pokemon.number ? 0 : 50,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: item.img,
                            fit: BoxFit.fill,
                            color: item.number == pokemon.number
                                ? null
                                : Colors.black.withOpacity(.5),
                            height: 100,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.7,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
