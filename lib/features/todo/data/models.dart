

import 'package:firebase_database/firebase_database.dart';
import 'package:todo_app/features/todo/domain/entities.dart';

class ToDoModel extends ToDo {
  ToDoModel.fromSnapshot(DataSnapshot snapshot) : super('', '') {
    this.titulo = snapshot.key;
    this.toDo = snapshot.value;
  }
}