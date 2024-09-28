import 'package:flutter/material.dart';

enum PokemonTypeEnum {
  grass('Grass', Colors.green),
  poison('Poison', Colors.deepPurple),
  fire('Fire', Colors.redAccent),
  flying('Flying', Colors.pinkAccent),
  water('Water', Colors.lightBlue),
  bug('Bug', Colors.lightGreen),
  normal('Normal', Colors.amber),
  electric('Electric', Colors.yellow),
  fighting('Fighting', Colors.red),
  psychic('Psychic', Colors.pinkAccent),
  rock('Rock', Colors.brown),
  steel('Steel', Colors.grey),
  ground('Ground', Colors.brown),
  ice('Ice', Colors.cyan),
  ghost('Ghost', Colors.purple),
  dragon('Dragon', Colors.pinkAccent),
  dark('Dark', Colors.black),
  unknown('Unknown', Colors.lightBlue);

  final String displayName;
  final Color color;

  const PokemonTypeEnum(this.displayName, this.color);

  static PokemonTypeEnum parse(String rawValue) => values.firstWhere(
        (e) => e.name.toLowerCase() == rawValue.toLowerCase(),
        orElse: () {
          print(rawValue);
          return unknown;
        },
      );
}
