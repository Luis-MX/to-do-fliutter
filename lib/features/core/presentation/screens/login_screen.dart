import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/features/core/presentation/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: 'Correo'
              ),
            ),
            PasswordInput(
              controller: _controllerPassword,
            ),
            SizedBox(height: 24.0,),
            Text('¿No tienes cuenta?'),
            RaisedButton(
              child: Text("Crear Cuenta"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => SignUpScreen()
                ));
              },
            )
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

class PasswordInput extends StatefulWidget {

  final TextEditingController controller;

  const PasswordInput({Key key, this.controller}) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {

  bool ocultarPassword = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: ocultarPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        labelText: 'Password',
        suffix: IconButton(
          icon: Icon(Icons.remove_red_eye, color: ocultarPassword ? Colors.grey : Colors.blue,),
          onPressed: () {
            // Mostrar / Ocultar password
            setState(() {
              ocultarPassword = !ocultarPassword;
            });
          },
        )
      ),
    );
  }
}


