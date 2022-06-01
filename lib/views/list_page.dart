import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proyek_prak/models/boxes.dart';
import 'package:proyek_prak/models/recipes.dart';
import 'package:proyek_prak/views/home_page.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5D5B5B),
      appBar: AppBar(
          leading:
            IconButton(
            onPressed: (){
              Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                builder: (context) => HomePage()));
              },
                icon: Icon(Icons.arrow_back),
                tooltip: "Back",
              ),
        title: Text("Your List")
        ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Item>(HiveBoxes.recipes).listenable(),
        builder: (context, Box<Item> box, _) {
          if (box.values.isEmpty) {
            return Center(
              child: Text(
                  "Your list is empty",
                  style: TextStyle(
                    fontFamily: 'avenir',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
              ),
            );
        }
        return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              Item? res = box.getAt(index);
              return Dismissible(
                  background: Container(
                  color: Colors.red,
              ),
                  key: UniqueKey(),
                  onDismissed: (direction) {
                  res!.delete();
              },
                  child: Card(
                    color: Color(0xFFE1E1E1),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Image.network(
                                res!.imageUrl,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          res!.title,
                          style: TextStyle(
                            fontFamily: 'avenir',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,),
                        ),
                      ],
                    ),
                  ),
              );
            }
        );
        },
      ),
    );
  }
}
