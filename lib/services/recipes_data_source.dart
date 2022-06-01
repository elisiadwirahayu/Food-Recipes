import 'package:proyek_prak/services/base_network.dart';

class RecipesDataSource {
  static RecipesDataSource instance = RecipesDataSource();
  Future<Map<String, dynamic>> loadRecipes() {
    return BaseNetwork.get("data");
  }
}