class FoodRecipes {
  List<Recipes>? _recipes;

  FoodRecipes({List<Recipes>? recipes}) {
    if (recipes != null) {
      this._recipes = recipes;
    }
  }

  List<Recipes>? get recipes => _recipes;
  set recipes(List<Recipes>? recipes) => _recipes = recipes;

  FoodRecipes.fromJson(Map<String, dynamic> json) {
    if (json['recipes'] != null) {
      _recipes = <Recipes>[];
      json['recipes'].forEach((v) {
        _recipes!.add(new Recipes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._recipes != null) {
      data['recipes'] = this._recipes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Recipes {
  String? _id;
  String? _title;
  String? _imageUrl;
  List<String>? _ingredients;
  List<String>? _steps;

  Recipes(
      {String? id,
        String? title,
        String? imageUrl,
        List<String>? ingredients,
        List<String>? steps}) {
    if (id != null) {
      this._id = id;
    }
    if (title != null) {
      this._title = title;
    }
    if (imageUrl != null) {
      this._imageUrl = imageUrl;
    }
    if (ingredients != null) {
      this._ingredients = ingredients;
    }
    if (steps != null) {
      this._steps = steps;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get imageUrl => _imageUrl;
  set imageUrl(String? imageUrl) => _imageUrl = imageUrl;
  List<String>? get ingredients => _ingredients;
  set ingredients(List<String>? ingredients) => _ingredients = ingredients;
  List<String>? get steps => _steps;
  set steps(List<String>? steps) => _steps = steps;

  Recipes.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _imageUrl = json['imageUrl'];
    _ingredients = json['ingredients'].cast<String>();
    _steps = json['steps'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['imageUrl'] = this._imageUrl;
    data['ingredients'] = this._ingredients;
    data['steps'] = this._steps;
    return data;
  }
}
