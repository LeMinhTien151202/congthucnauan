import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';
import 'package:provider/provider.dart';

class UpdateRecipeScreen extends StatefulWidget {
  final Recipe recipe;

  const UpdateRecipeScreen({required this.recipe, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UpdateRecipeScreenState createState() => _UpdateRecipeScreenState();
}

class _UpdateRecipeScreenState extends State<UpdateRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String description;
  late List<String> ingredients;
  late String instructions;

  @override
  void initState() {
    super.initState();
    name = widget.recipe.name;
    description = widget.recipe.description;
    ingredients = widget.recipe.ingredients;
    instructions = widget.recipe.instructions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Recipe")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: "Name"),
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                initialValue: description,
                decoration: const InputDecoration(labelText: "Description"),
                onSaved: (value) => description = value!,
              ),
              TextFormField(
                initialValue: widget.recipe.ingredients.join(", "), // Hiển thị ingredients dạng chuỗi
                decoration: const InputDecoration(labelText: "Ingredients (comma separated)"),
                onSaved: (value) => ingredients = value!.split(",").map((e) => e.trim()).toList(),
              ),
              TextFormField(
                initialValue: instructions,
                decoration: const InputDecoration(labelText: "Instructions"),
                onSaved: (value) => instructions = value!,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text("Save"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final updatedRecipe = widget.recipe.copyWith(
                      name: name,
                      description: description,
                      ingredients: ingredients,
                      instructions: instructions,
                    );
                    context.read<RecipeService>().updateRecipe(updatedRecipe).then((_) {
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
