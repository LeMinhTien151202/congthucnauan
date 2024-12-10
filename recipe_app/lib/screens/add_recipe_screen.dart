import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String description = "";
  List<String> ingredients = [];
  String instructions = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Recipe")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Name"),
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Description"),
                onSaved: (value) => description = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Ingredients (comma separated)"),
                onSaved: (value) => ingredients = value!.split(","),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Instructions"),
                onSaved: (value) => instructions = value!,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text("Save"),
                onPressed: () {
                  _formKey.currentState!.save();
                  final recipe = Recipe(
                    id: null,
                    name: name,
                    description: description,
                    ingredients: ingredients,
                    instructions: instructions,
                  );
                  context.read<RecipeService>().addRecipe(recipe);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
