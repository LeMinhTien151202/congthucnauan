import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/recipe.dart';
import './services/recipe_service.dart';
import './screens/home_screen.dart';
import './screens/recipe_detail_screen.dart';
import './screens/add_recipe_screen.dart';
import 'screens/update_recipe_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RecipeService(), // Cung cấp RecipeService cho cây widget
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Recipe Manager",
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/detail': (context) => const RecipeDetailScreen(),
        '/add': (context) => const AddRecipeScreen(),
        '/update': (context) => UpdateRecipeScreen(
              recipe: ModalRoute.of(context)!.settings.arguments as Recipe,
            ), // Chuyển đối tượng Recipe làm tham số
      },
    );
  }
}
