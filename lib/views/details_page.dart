import 'package:flutter/material.dart';
import 'package:proyek_prak/models/food_recipes.dart';

class DetailsPage extends StatelessWidget {
  final Recipes data;
  DetailsPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE1E1E1),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              title: Text(
                  "${data?.title}",
                  style: TextStyle(
                    fontFamily: 'avenir',),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: "${data?.id}",
                  child: FadeInImage(
                    image: NetworkImage("${data?.imageUrl}"),
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/images/loading.gif'),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Container(
          color: Color(0xFFE1E1E1),
          padding: EdgeInsets.only(top: 8.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Text('Ingredients',
                    style: TextStyle(
                        fontFamily: 'avenir',
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                IngredientsWidget(
                  ingredients: data?.ingredients,
                ),
                Divider(endIndent: 40.0, indent: 40.0),
                Text('Steps',
                    style: TextStyle(
                        fontFamily: 'avenir',
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                RecipeSteps(
                  steps: data?.steps,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecipeSteps extends StatelessWidget {
  final List<String>? steps;
  RecipeSteps({this.steps = const []});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: steps?.length,
      padding: const EdgeInsets.all(0.0),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Text('${index + 1}',
                  style: TextStyle(
                      fontFamily: 'avenir',
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  )
              ),
            ),
            title: Text(steps![index],
                style: TextStyle(
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.bold,
                    fontSize: 16)));
      },
    );
  }
}

class IngredientsWidget extends StatelessWidget {
  final List<String>? ingredients;
  IngredientsWidget({this.ingredients});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        itemCount: ingredients!.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chip(
              backgroundColor: Theme.of(context).accentColor,
              label: Text(ingredients![index],
                  style: TextStyle(
                      fontFamily: 'avenir',
                      color: Colors.black,
                      fontWeight: FontWeight.bold)
              ),
            ),
          );
        },
      ),
    );
  }
}