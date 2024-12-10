import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/screens/recipe_detail_screen.dart';



void main() {
  testWidgets('RecipeDetailScreen hiển thị thông tin chi tiết công thức', (WidgetTester tester) async {
    // Tạo một công thức giả
    final recipe = Recipe(
      id: 1,
      name: 'Test Recipe',
      description: 'This is a test recipe description.',
      ingredients: ['Ingredient 1', 'Ingredient 2'],
      instructions: 'Step 1: Do this.\nStep 2: Do that.',
    );

    // Xây dựng widget với RecipeDetailScreen và truyền công thức qua arguments
    await tester.pumpWidget(
      MaterialApp(
        onGenerateRoute: (settings) {
          if (settings.name == '/') {
            return MaterialPageRoute(
              builder: (context) => const RecipeDetailScreen
              (),
              settings: RouteSettings(arguments: recipe),
            );
          }
          return null;
        },
      ),
    );

    // Đợi giao diện được xây dựng
    await tester.pumpAndSettle();

    // Kiểm tra tiêu đề là tên của công thức
    expect(find.text(recipe.name), findsOneWidget);

    // Kiểm tra phần mô tả của công thức
    expect(find.text('Description:'), findsOneWidget);
    expect(find.text(recipe.description), findsOneWidget);

    // Kiểm tra danh sách nguyên liệu
    expect(find.text('Ingredients:'), findsOneWidget);
    for (final ingredient in recipe.ingredients) {
      expect(find.text('- $ingredient'), findsOneWidget);
    }

    // Kiểm tra phần hướng dẫn
    expect(find.text('Instructions:'), findsOneWidget);
    expect(find.text(recipe.instructions), findsOneWidget);
  });
}
