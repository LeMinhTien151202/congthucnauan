import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/screens/home_screen.dart';
import 'package:recipe_app/services/recipe_service.dart';


void main() {
  testWidgets('AppBar title is "Recipe Manager"', (WidgetTester tester) async {
    // Mock RecipeService
    final mockRecipeService = RecipeService();

    // Build ứng dụng với Provider cho RecipeService
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<RecipeService>.value(
          value: mockRecipeService,
          child: const HomeScreen(),
        ),
      ),
    );

    // Kiểm tra xem AppBar có chứa tên "Recipe Manager" không
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Recipe Manager'), findsOneWidget);
  });
}
