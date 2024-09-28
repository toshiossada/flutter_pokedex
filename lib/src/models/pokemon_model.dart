import '../enums/pokemon_types_enum.dart';

class PokemonModel {
  final int number;
  final String name;
  final String img;
  final List<PokemonTypeEnum> types;
  final List<PokemonModel> nextEvolution;
  final List<PokemonModel> prevEvolution;

  List<PokemonModel> get evolutions => [
        ...prevEvolution,
        this,
        ...nextEvolution,
      ];

  PokemonModel({
    required this.name,
    required this.number,
    required this.img,
    required this.types,
    required this.nextEvolution,
    required this.prevEvolution,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      name: json['name'],
      number: int.parse(json['num']),
      img: json['img'] ??
          'http://www.serebii.net/pokemongo/pokemon/${json['num']}.png',
      types: json['type'] == null
          ? <PokemonTypeEnum>[]
          : json['type']
              .map<PokemonTypeEnum>((e) => PokemonTypeEnum.parse(e))
              .toList(),
      nextEvolution: json['next_evolution'] == null
          ? []
          : (json['next_evolution'] as List)
              .map((e) => PokemonModel.fromJson(e))
              .toList(),
      prevEvolution: json['prev_evolution'] == null
          ? []
          : (json['prev_evolution'] as List)
              .map((e) => PokemonModel.fromJson(e))
              .toList(),
    );
  }
}
