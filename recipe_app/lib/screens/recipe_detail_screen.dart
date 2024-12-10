import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipe = ModalRoute.of(context)!.settings.arguments as Recipe;

    return Scaffold(
      appBar: AppBar(title: Text(recipe.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Description:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(recipe.description),
            SizedBox(height: 16),
            const Text("Ingredients:", style: TextStyle(fontWeight: FontWeight.bold)),
            ...recipe.ingredients.map((ing) => Text("- $ing")).toList(),
            SizedBox(height: 16),
            const Text("Instructions:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(recipe.instructions),
          ],
        ),
      ),
    );
  }
}
