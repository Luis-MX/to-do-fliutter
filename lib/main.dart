import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginPage(title: 'Bienvenido',);
          }
        },
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controllerEmail,
            ),
            TextField(
              controller: _controllerPassword,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.arrow_forward_ios),
        onPressed: () {
          FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _controllerEmail.text,
            password: _controllerPassword.text
          ).then((val) {}, onError: (error) {
            print('onError');
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (dialogContext) {
                return AlertDialog(
                  title: Text('Login'),
                  content: Text('${error}'),
                  actions: <Widget>[
                    RaisedButton(
                      child: Text('Aceptar'),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                    )
                  ],
                );
              }
            );
          });
        },
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
      ),
      body: Center(
        child: Text('Hola: '),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        onPressed: () {
          FirebaseAuth.instance.signOut();
        },
      ),
    );
  }
}