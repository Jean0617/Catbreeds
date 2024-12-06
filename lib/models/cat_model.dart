class CatModel {
  final String id;
  final String name;
  final String origin;
  final int adaptability;
  final int intelligence;
  String urlImage;
  final String reference_image_id;
  final String description;
  final String temperament;

  CatModel({
    required this.id,
    required this.name,
    required this.origin,
    required this.adaptability,
    required this.intelligence,
    required this.urlImage,
    required this.reference_image_id,
    required this.description,
    required this.temperament
  });

  factory CatModel.fromJson(Map json){
    return CatModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      origin: json['origin'] ?? '',
      adaptability: json['adaptability'] ?? '',
      intelligence: json['intelligence'] ?? '',
      urlImage: '',
      reference_image_id: json['reference_image_id'] ?? '',
      description: json['description'] ?? '',
      temperament: json['temperament'] ?? '',
    );
  }
}