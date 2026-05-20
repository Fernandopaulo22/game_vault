class GameModel {
  int? id;
  String title;
  String category;
  String rarity;
  String status;
  String condition;
  double paidValue;
  double estimatedValue;
  String location;
  String imagePath;

  GameModel({
    this.id,
    required this.title,
    required this.category,
    required this.rarity,
    required this.status,
    required this.condition,
    required this.paidValue,
    required this.estimatedValue,
    required this.location,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'rarity': rarity,
      'status': status,
      'condition': condition,
      'paidValue': paidValue,
      'estimatedValue': estimatedValue,
      'location': location,
      'imagePath': imagePath,
    };
  }

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      id: map['id'],
      title: map['title'],
      category: map['category'],
      rarity: map['rarity'],
      status: map['status'],
      condition: map['condition'],
      paidValue: map['paidValue'],
      estimatedValue: map['estimatedValue'],
      location: map['location'],
      imagePath: map['imagePath'],
    );
  }
}