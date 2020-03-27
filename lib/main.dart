import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features/core/presentation/screens/login_screen.dart';
import 'features/core/presentation/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen(user: snapshot.data,);
          } else {
            return LoginScreen(title: 'Bienvenido',);
          }
        },
      ),
    );
  }
}
