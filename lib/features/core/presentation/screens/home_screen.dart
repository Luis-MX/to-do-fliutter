import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {

  final FirebaseUser user;

  const HomeScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseReference reference = FirebaseDatabase.instance.reference().child('todo');
    reference.keepSynced(true);
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text('Bienvenido'),
          subtitle: Text(user.email),
        )
      ),
      body: StreamBuilder<Event>(
        stream: reference.onValue,
        builder: (_, snapshot) {
          if (snapshot.hasData && snapshot.data.snapshot != null && snapshot.data.snapshot.value != null) {
            List todos = snapshot.data.snapshot.value as List;
            return ListView(
              children: todos.where((elemento) => elemento != null).map((elemento) {
                return ListTile(
                  title: Text('$elemento'),
                  onTap: () {
                    //
                  },
                );
              }).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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