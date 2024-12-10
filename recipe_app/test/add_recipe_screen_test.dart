import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/screens/add_recipe_screen.dart';
import 'package:recipe_app/services/recipe_service.dart';

void main() {
  testWidgets('AddRecipeScreen test - check AppBar title and TextFormFields', (WidgetTester tester) async {
    // Tạo widget mà không cần RecipeService thực sự
    await tester.pumpWidget(
      MaterialApp(
        home: Provider<RecipeService>(
          create: (_) => RecipeService(), // RecipeService không cần được kiểm tra ở đây
          child: const AddRecipeScreen(),
        ),
      ),
    );

    // Kiểm tra AppBar title
    expect(find.text("Add Recipe"), findsOneWidget);

    // Kiểm tra rằng các TextFormField đều có mặt
    expect(find.byType(TextFormField), findsNWidgets(4));
    expect(find.widgetWithText(TextFormField, "Name"), findsOneWidget);
    expect(find.widgetWithText(TextFormField, "Description"), findsOneWidget);
    expect(find.widgetWithText(TextFormField, "Ingredients (comma separated)"), findsOneWidget);
    expect(find.widgetWithText(TextFormField, "Instructions"), findsOneWidget);
  });
}
