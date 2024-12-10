import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/widgets/recipe_card.dart';


void main() {
  testWidgets('RecipeCard hiển thị thông tin công thức đúng', (WidgetTester tester) async {
    // Chuẩn bị dữ liệu
    final recipe = Recipe(
      id: 1,
      name: 'Recipe 1',
      description: 'Description 1',
      ingredients: ['Ingredient 1'],
      instructions: 'Instructions 1',
    );

    // Xây dựng widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RecipeCard(
          recipe: recipe,
          onUpdate: () {},
          onDelete: () {},
          onTap: () {},
        ),
      ),
    ));

    // Kiểm tra xem tên và mô tả công thức có hiển thị đúng không
    expect(find.text('Recipe 1'), findsOneWidget);
    expect(find.text('Description 1'), findsOneWidget);
  });

  testWidgets('RecipeCard gọi onUpdate khi nhấn nút chỉnh sửa', (WidgetTester tester) async {
    bool onUpdateCalled = false;

    // Chuẩn bị dữ liệu và sự kiện
    final recipe = Recipe(
      id: 1,
      name: 'Recipe 1',
      description: 'Description 1',
      ingredients: ['Ingredient 1'],
      instructions: 'Instructions 1',
    );

    // Xây dựng widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RecipeCard(
          recipe: recipe,
          onUpdate: () {
            onUpdateCalled = true;
          },
          onDelete: () {},
          onTap: () {},
        ),
      ),
    ));

    // Nhấn nút chỉnh sửa
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pump();

    // Kiểm tra xem onUpdate có được gọi không
    expect(onUpdateCalled, true);
  });

  testWidgets('RecipeCard gọi onDelete khi xác nhận xóa công thức', (WidgetTester tester) async {
    bool onDeleteCalled = false;

    // Chuẩn bị dữ liệu và sự kiện
    final recipe = Recipe(
      id: 1,
      name: 'Recipe 1',
      description: 'Description 1',
      ingredients: ['Ingredient 1'],
      instructions: 'Instructions 1',
    );

    // Xây dựng widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RecipeCard(
          recipe: recipe,
          onUpdate: () {},
          onDelete: () {
            onDeleteCalled = true;
          },
          onTap: () {},
        ),
      ),
    ));

    // Nhấn nút xóa
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    // Kiểm tra xem hộp thoại xóa có xuất hiện không
    expect(find.text('Are you sure you want to delete this recipe?'), findsOneWidget);

    // Nhấn nút "Delete" để xác nhận xóa
    await tester.tap(find.text('Delete'));
    await tester.pump();

    // Kiểm tra xem onDelete có được gọi không
    expect(onDeleteCalled, true);
  });

  testWidgets('RecipeCard không gọi onDelete khi nhấn Cancel trong hộp thoại xóa', (WidgetTester tester) async {
    bool onDeleteCalled = false;

    // Chuẩn bị dữ liệu và sự kiện
    final recipe = Recipe(
      id: 1,
      name: 'Recipe 1',
      description: 'Description 1',
      ingredients: ['Ingredient 1'],
      instructions: 'Instructions 1',
    );

    // Xây dựng widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RecipeCard(
          recipe: recipe,
          onUpdate: () {},
          onDelete: () {
            onDeleteCalled = true;
          },
          onTap: () {},
        ),
      ),
    ));

    // Nhấn nút xóa
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    // Kiểm tra xem hộp thoại xóa có xuất hiện không
    expect(find.text('Are you sure you want to delete this recipe?'), findsOneWidget);

    // Nhấn nút "Cancel" để hủy bỏ
    await tester.tap(find.text('Cancel'));
    await tester.pump();

    // Kiểm tra xem onDelete không được gọi
    expect(onDeleteCalled, false);
  });

  testWidgets('RecipeCard gọi onTap khi nhấn vào card', (WidgetTester tester) async {
    bool onTapCalled = false;

    // Chuẩn bị dữ liệu và sự kiện
    final recipe = Recipe(
      id: 1,
      name: 'Recipe 1',
      description: 'Description 1',
      ingredients: ['Ingredient 1'],
      instructions: 'Instructions 1',
    );

    // Xây dựng widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RecipeCard(
          recipe: recipe,
          onUpdate: () {},
          onDelete: () {},
          onTap: () {
            onTapCalled = true;
          },
        ),
      ),
    ));

    // Nhấn vào Card
    await tester.tap(find.byType(Card));
    await tester.pump();

    // Kiểm tra xem onTap có được gọi không
    expect(onTapCalled, true);
  });
}
