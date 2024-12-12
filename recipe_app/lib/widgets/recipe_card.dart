import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;
  final VoidCallback onTap; // Sự kiện cho bấm vào để xem chi tiết món ăn

  const RecipeCard({super.key, 
    required this.recipe,
    required this.onUpdate,
    required this.onDelete,
    required this.onTap, // Thêm tham số onTap
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(recipe.name),
        subtitle: Text(recipe.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onUpdate,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _showDeleteConfirmation(context),
            ),
          ],
        ),
        onTap: onTap, // Gọi sự kiện onTap khi bấm vào Card
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Recipe"),
          content: const Text("Are you sure you want to delete this recipe?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () {
                onDelete();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
