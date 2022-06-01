import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proyek_prak/models/boxes.dart';
import 'package:proyek_prak/models/food_recipes.dart';
import 'package:proyek_prak/models/recipes.dart';
import 'package:proyek_prak/views/list_page.dart';
import 'package:proyek_prak/views/details_page.dart';
import 'package:proyek_prak/views/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proyek_prak/services/recipes_data_source.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences logindata;
  late String username;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
    });
  }

  late List<List<String>> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5D5B5B),
      appBar: AppBar(
        title: Text("Recipes List"),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ListPage()));
            },
            icon: Icon(Icons.list),
            tooltip: "List",
          ),
          SizedBox(width: 10,),
          IconButton(
              onPressed: (){
                logindata.setBool('login', true);
                Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => LoginPage()));
              },
              icon: Icon(Icons.logout),
              tooltip: "Logout",
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child:
            _buildRecipesBody(),
      ),
    );
  }

  Widget _buildRecipesBody() {
    return FutureBuilder(
      future: RecipesDataSource.instance.loadRecipes(),
      builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
          ) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }
        if (snapshot.hasData) {
          FoodRecipes foodRecipes =
          FoodRecipes.fromJson(snapshot.data);
          return _buildSuccessSection(foodRecipes);
        }
        return _buildLoadingSection();
      },
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(FoodRecipes data) {
    return Container(
      child: ListView.builder(
          itemCount: data.recipes?.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailsPage(data: data.recipes![index]);
                }));
              },
              child: Card(
                color: Color(0xFFE1E1E1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Image.network(
                                "${data.recipes?[index].imageUrl}",
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${data.recipes?[index].title}",
                          style: TextStyle(
                            fontFamily: 'avenir',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,),
                        ),
                      ],
                    ),
                    IconButton(
                      tooltip: "Masukkan ke list",
                      icon: Icon(
                        Icons.add_circle_rounded,
                        color: Color(0xFFFF5722),
                      ),
                      onPressed: () {
                          Box<Item> recipesbox = Hive.box<Item>(HiveBoxes.recipes);
                          recipesbox.add(
                              Item(
                                imageUrl: data!.recipes![index].imageUrl!,
                                title: data!.recipes![index].title!
                          ));
                          SnackBar snackBar = SnackBar(content: Text("Recipe berhasil ditambahkan ke list"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          print(recipesbox);
                      },
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}