import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/screens/update_recipe_screen.dart';
import 'package:recipe_app/services/recipe_service.dart';

import 'mock_recipe_service.dart';
 // Import lớp mock service

void main() {
  testWidgets('UpdateRecipeScreen cập nhật công thức món ăn thành công', (WidgetTester tester) async {
    // Sử dụng MockRecipeService
    final mockRecipeService = MockRecipeService();

    // Tạo công thức ban đầu để cập nhật
    final initialRecipe = Recipe(
      id: 1,
      name: "Original Recipe",
      description: "Original Description",
      ingredients: ["Ingredient1", "Ingredient2"],
      instructions: "Original Instructions",
    );

    // Xây dựng ứng dụng với ChangeNotifierProvider
    await tester.pumpWidget(
      ChangeNotifierProvider<RecipeService>.value(
        value: mockRecipeService,
        child: MaterialApp(
          home: UpdateRecipeScreen(recipe: initialRecipe),
        ),
      ),
    );

    // Kiểm tra màn hình `UpdateRecipeScreen` đã được xây dựng
    expect(find.byType(UpdateRecipeScreen), findsOneWidget);

    // Kiểm tra dữ liệu ban đầu đã được hiển thị
    expect(find.text("Original Recipe"), findsOneWidget);
    expect(find.text("Original Description"), findsOneWidget);
    expect(find.text("Ingredient1, Ingredient2"), findsOneWidget);
    expect(find.text("Original Instructions"), findsOneWidget);

    // Nhập dữ liệu mới
    await tester.enterText(find.widgetWithText(TextFormField, "Name"), "Updated Recipe");
    await tester.enterText(find.widgetWithText(TextFormField, "Description"), "Updated Description");
    await tester.enterText(find.widgetWithText(TextFormField, "Ingredients (comma separated)"), "Updated Ingredient1, Updated Ingredient2");
    await tester.enterText(find.widgetWithText(TextFormField, "Instructions"), "Updated Instructions");

    // Nhấn nút "Save"
    await tester.tap(find.widgetWithText(ElevatedButton, "Save"));
    await tester.pumpAndSettle();

    // Kiểm tra công thức đã được cập nhật
    expect(mockRecipeService.updatedRecipe, isNotNull);
    expect(mockRecipeService.updatedRecipe!.name, "Updated Recipe");
    expect(mockRecipeService.updatedRecipe!.description, "Updated Description");
    expect(mockRecipeService.updatedRecipe!.ingredients, ["Updated Ingredient1", "Updated Ingredient2"]);
    expect(mockRecipeService.updatedRecipe!.instructions, "Updated Instructions");

    // Kiểm tra màn hình `UpdateRecipeScreen` đã được đóng
    expect(find.byType(UpdateRecipeScreen), findsNothing);
  });
}
