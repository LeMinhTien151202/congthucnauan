import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class RecipeService extends ChangeNotifier {  // Kế thừa từ ChangeNotifier
  final String baseUrl = 'http://10.0.2.2:3000/recipes';

  List<Recipe> _recipes = [];

  List<Recipe> get recipes => _recipes;

  Future<List<Recipe>> fetchRecipes() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      _recipes = data.map((recipe) => Recipe.fromJson(recipe)).toList();
      notifyListeners();  // Thông báo khi dữ liệu thay đổi
      return _recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<void> addRecipe(Recipe recipe) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(recipe.toJson()),
    );
    if (response.statusCode == 200) {
      _recipes.add(recipe);  // Cập nhật danh sách sau khi thêm
      notifyListeners();  // Thông báo khi thêm mới
    } else {
      throw Exception('Failed to add recipe');
    }
  }

  Future<void> updateRecipe(Recipe recipe) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${recipe.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(recipe.toJson()),
    );
    if (response.statusCode == 200) {
      final index = _recipes.indexWhere((r) => r.id == recipe.id);
      if (index != -1) {
        _recipes[index] = recipe;  // Cập nhật món ăn trong danh sách
        notifyListeners();  // Thông báo khi cập nhật
      }
    } else {
      throw Exception('Failed to update recipe');
    }
  }

  Future<void> deleteRecipe(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      _recipes.removeWhere((recipe) => recipe.id == id);  // Xóa món ăn khỏi danh sách
      notifyListeners();  // Thông báo khi xóa
    } else {
      throw Exception('Failed to delete recipe');
    }
  }
}
