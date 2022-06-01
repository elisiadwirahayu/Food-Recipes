import 'package:flutter/material.dart';
import 'package:proyek_prak/views/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
// Create a text controller and use it to retrieve the current value
// of the TextField.
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  late SharedPreferences logindata;
  late bool newuser;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  void dispose() {
// Clean up the controller when the widget is disposed.
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE1E1E1),
      appBar: AppBar(
        title: Text("Food Recipes"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo.png',
              width: 200,
              scale: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: username_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: password_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50.0),
                ),
                onPressed: () {
                  String username = username_controller.text;
                  String password = password_controller.text;
                  if (username != '' && password != '') {
                    print('Successfull');
                    logindata.setBool('login', false);
                    logindata.setString('username', username);
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },// Respon ketika button ditekan
                child: Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}