class PokemonModel {
  final int number;
  final String name;
  final String img;
  final List<String> types;
  final List<PokemonModel> nextEvolution;

  PokemonModel({
    required this.name,
    required this.number,
    required this.img,
    required this.types,
    required this.nextEvolution,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      name: json['name'],
      number: json['num'],
      img: json['img'],
      types: json['type'],
      nextEvolution: json['type'] == null
          ? []
          : (json['next_evolution'] as List<Map<String, dynamic>>)
              .map((e) => PokemonModel.fromJson(e))
              .toList(),
    );
  }
}
