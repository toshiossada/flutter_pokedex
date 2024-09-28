import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/pokemon_model.dart';
import '../../widgets/pokemon_badge_type.dart';

class PokemonCard extends StatelessWidget {
  final PokemonModel pokemon;
  final void Function()? onPress;

  const PokemonCard(
    this.pokemon, {
    super.key,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: pokemon.types.first.color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onPress,
        splashColor: Colors.white10,
        highlightColor: Colors.white10,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  Hero(
                    tag: '${pokemon.number}${pokemon.name}',
                    child: Text(
                      pokemon.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '#${pokemon.number.toString().padLeft(3, '0')}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              _CardContent(pokemon),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final PokemonModel pokemon;

  const _CardContent(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: _buildTypes(context),
        ),
        Hero(
          tag: '${pokemon.number}${pokemon.name}_image',
          child: CachedNetworkImage(
            imageUrl: pokemon.img,
            height: 90,
            placeholder: (context, url) => const SizedBox(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildTypes(BuildContext context) {
    return pokemon.types
        .take(2)
        .map(
          (type) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: PokemonBadgeType(
              type: type,
              sameColor: type.color == pokemon.types.first.color,
            ),
          ),
        )
        .toList();
  }
}
