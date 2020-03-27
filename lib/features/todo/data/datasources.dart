

import 'package:firebase_database/firebase_database.dart';
import 'package:todo_app/features/todo/domain/entities.dart';

class Database {
  void save(ToDo toDo) {
    FirebaseDatabase.instance.reference().child('todo').child(toDo.titulo).set(toDo.toDo);
  }
}