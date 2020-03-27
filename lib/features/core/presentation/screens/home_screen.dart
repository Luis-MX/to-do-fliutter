import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/features/todo/presentation/screens/add_screen.dart';

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
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: StreamBuilder<Event>(
        stream: reference.onValue,
        builder: (_, snapshot) {
          if (snapshot.hasData && snapshot.data.snapshot != null && snapshot.data.snapshot.value != null) {
            Map todos = snapshot.data.snapshot.value as Map;
            print(todos);
            return ListView(
              children: todos.keys.map((elemento) {
                return ListTile(
                  title: Text('$elemento'),
                  subtitle: Text('${todos[elemento]}'),
                  onTap: () {
                    FirebaseDatabase.instance.reference().child('todo').child(elemento).remove();
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
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => AddScreen()
          ));
        },
      ),
    );
  }
}