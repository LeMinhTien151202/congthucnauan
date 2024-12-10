
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/services/recipe_service.dart';


class MockRecipeService extends RecipeService {

  @override
  Future<List<Recipe>> fetchRecipes() async {
    return [];
  }
  Recipe? updatedRecipe;

  @override
  Future<void> updateRecipe(Recipe recipe) async {
    updatedRecipe = recipe; // Lưu lại công thức được cập nhật
  }
}
