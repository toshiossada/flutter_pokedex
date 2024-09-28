import 'package:flutter/material.dart';

import '../../enums/pokemon_types_enum.dart';

class PokemonBadgeType extends StatelessWidget {
  const PokemonBadgeType({
    super.key,
    required this.type,
    this.sameColor = false,
    this.fontSize = 8,
  });

  final PokemonTypeEnum type;
  final bool sameColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: sameColor ? Colors.black.withOpacity(0.6) : type.color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(
          type.displayName,
          textScaler: TextScaler.noScaling,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: sameColor ? Colors.white : Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
