import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/recipe_service.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Recipe>> futureRecipes;

  @override
  void initState() {
    super.initState();
    _refreshRecipes();
  }

  void _refreshRecipes() {
    futureRecipes = context.read<RecipeService>().fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recipe Manager")),
      body: FutureBuilder<List<Recipe>>(
        future: futureRecipes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          final recipes = snapshot.data!;
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return RecipeCard(
                recipe: recipes[index],
                onUpdate: () async {
                  await Navigator.pushNamed(context, '/update', arguments: recipes[index]);
                  setState(() {
                    _refreshRecipes();
                  });
                },
                onDelete: () {
                  context.read<RecipeService>().deleteRecipe(recipes[index].id!).then((_) {
                    setState(() {
                      _refreshRecipes();
                    });
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to delete recipe: $error")),
                    );
                  });
                },
                onTap: () {
                  // Điều hướng tới màn hình chi tiết món ăn
                  Navigator.pushNamed(context, '/detail', arguments: recipes[index]);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {
            _refreshRecipes();
          });
        },
      ),
    );
  }
}
