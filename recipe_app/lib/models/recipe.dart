class Recipe {
  int? id;
  String name;
  String description;
  List<String> ingredients;
  String instructions;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.instructions,
  });

  // Phương thức copyWith
  Recipe copyWith({
    int? id,
    String? name,
    String? description,
    List<String>? ingredients,
    String? instructions,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
    );
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      ingredients: (json['ingredients'] as String).split(','),
      instructions: json['instructions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'ingredients': ingredients.join(','),
      'instructions': instructions,
    };
  }
}
